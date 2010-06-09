class ResultsController < ApplicationController
  
  layout 'application'
  before_filter :admin_required, :only => [:new, :create, :update]
  before_filter :login_required, :only => [:create_custom, :destroy]
  
  # GET /results
  # GET /results.xml
  def index
    #@results = Result.all
    @run = Run.find(params[:run_id]) if params[:run_id] && params[:run_id].to_i > 0
    @runs = Run.find(:all, :order => "eventday desc", :conditions => {:showresults => true})
    #@results = Result.all
    @categories = Result.find_by_sql("select run_id, cat from results group by run_id, cat;")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @results }
    end
  end


  def create_custom

    res_data = params[:result]
    res_data.each_pair { |k,v| v = v.to_i if k.to_s.include?("custom_all_") }
    res_data[:is_custom] = true
    res_data[:user_id] = current_user.id
    res_data[:edad] = current_user.age if !res_data[:edad] || res_data[:edad].empty?
    res_data[:time_in_seconds] = Filesupload::date_string_to_seconds(res_data[:time_in_seconds])
    res_data[:time_chip_in_seconds] = Filesupload::date_string_to_seconds(res_data[:time_chip_in_seconds])

    #res_data[:time_chip]
    #res_data[:cat]

    @result = Result.new(res_data)
    if @result.time_chip_in_seconds > 0
      @result.paso_in_seconds = @result.time_chip_in_seconds / @result.custom_run_distance  if @result.custom_run_distance > 0.0
    elsif @result.time_in_seconds > 0
      @result.paso_in_seconds = @result.time_in_seconds / @result.custom_run_distance  if @result.custom_run_distance > 0.0
    end


    if @result.save

      respond_to do |format|
        format.html {
           redirect_to(current_user.profile_path)
        }
        format.js {
          render :update do |pg|
            pg.insert_html :bottom, "new_results", :partial => "one_as_block", :locals => {:result => @result}
            pg.hide "custom_result_div"
          end
        }
      end

    else
      render :nothing => true
    end

  end


  def search
    max_per_page = 50
    params[:search].delete_if {|key, value| value.empty? } if params[:search]
    params[:search] = {} unless params[:search]
    page = params[:page].to_i
    params.delete("page")
    page = 1 if page.zero?
    videos = Video.find(:all, :conditions => ["run_id = ?", params[:search][:run_id]])
    run = Run.find(params[:search][:run_id])
    
    s_params = params[:search].clone
    
    params[:search][:club] ? club = params[:search][:club] : club = nil
    params[:search][:firstname] ? firstname = params[:search][:firstname] : firstname = nil
    params[:search][:lastname] ? lastname = params[:search][:lastname] : lastname = nil
    params[:search][:cat] ? cat= params[:search][:cat] : cat= nil
    
    sex = nil if params[:search][:sex] == "-1"
    sex = "f" if params[:search][:sex] == "0"
    sex = "m" if params[:search][:sex] == "1"
    
    params[:search].delete(:sex)
    params[:search].delete(:cat)
    params[:search].delete(:firstname)
    params[:search].delete(:lastname)
    params[:search].delete(:club)
    
    cond_sql = ""
    cond_sql << params[:search].map {|k,v| "#{k} = #{v}" }.join(" AND ")
    cond_sql << " AND instr(lcase(cat), ?)" if cat
    cond_sql << " AND instr(lcase(cat), ?)" if sex
    cond_sql << " AND instr(lcase(firstname), ?)" if firstname
    cond_sql << " AND instr(lcase(lastname), ?)" if lastname
    cond_sql << " AND instr(lcase(club), ?)" if club
    
    vals = []
    vals << cat.downcase if cat
    vals << sex if sex
    vals << firstname.downcase if firstname
    vals << lastname.downcase if lastname
    vals << club.downcase if club
    
    
    cond = []
    cond << cond_sql
    cond << vals
    cond.flatten!
    
    cats_count = Hash.new
    cats_count_res = Result.find_by_sql("select cat, count(cat) as cat_count from results where run_id = #{params[:search][:run_id]} group by cat")
    cats_count_res.each { |cc| cats_count[:"#{cc.cat}"] = cc.cat_count }
    
    res_count = Result.find_by_sql("select count(*) as total_count from results where run_id = #{params[:search][:run_id]}").first[:total_count]
    men_count = Result.find(:all, :select => "count(*) as men_count", :conditions => ["run_id = ? AND instr(lcase(cat), 'm')", params[:search][:run_id]]).first[:men_count]
    women_count = Result.find(:all, :select => "count(*) as women_count", :conditions => ["run_id = ? AND instr(lcase(cat), 'f')", params[:search][:run_id]]).first[:women_count]
    
    @results = Result.find(:all, :include => [:user], :conditions => cond, :offset => ((page-1)*max_per_page), :limit => max_per_page, :order => "rank_general asc")
    total_count = Result.find(:all, :select => "count(*) as total", :conditions => cond).first[:total]
    
    respond_to do |format|
      format.js {
        render :update do |pg|
          #pg[:results]
          #pg.call("$('#results').css({position:'relative', width:'2000px', height:'200px', border:1px solid black;})")

          ask_assign = false
          current_user_results = []

          if current_user
            has_auto_result = Result.find(:first, :conditions => {:user_id => current_user.id, :run_id => params[:search][:run_id]})
            has_user_assign = UserResultAssignment.find(:first, :conditions => {:user_id => current_user.id, :run_id => params[:search][:run_id]})

            current_user_results << Result.find(:all, :conditions => {:user_id => current_user.id})
            current_user_results << Result.find_by_sql("select results.* from results, user_result_assignments where user_result_assignments.result_id = results.id and user_result_assignments.user_id = #{current_user.id}")
            current_user_results.flatten!

            if !has_auto_result && !has_user_assign
              ask_assign = true
            end

          end

          time_partial_count = 0
          time_partial_count = 1 if @results.map {|x| x.time_chip_in_seconds1 > 0 ? 1 : nil}.compact.length > 0
          time_partial_count = 2 if @results.map {|x| x.time_chip_in_seconds2 > 0 ? 1 : nil}.compact.length > 0

		  result_width = 1150 + (time_partial_count * 150)

          pg.send :record, "$('#results').css({position:'relative', width:'#{result_width}px', height:'1480px', border:'1px solid black', 'background-color':'white', left:'-80px'})"
          pg.replace_html 'results', :partial => 'result_list', :locals => {:results => @results, :run => run, :time_partial_count => time_partial_count, :videos => videos, :res_count => res_count, :cats_count => cats_count, :men_count => men_count, :women_count => women_count, :total_count => total_count, :max_per_page => max_per_page, :s_params => s_params, :pagenum => page, :ask_assign => ask_assign, :current_user_results => current_user_results}
        end
      }
    end
  end

  # GET /results/1
  # GET /results/1.xml
  def show
    @result = Result.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @result }
    end
  end

  # GET /results/new
  # GET /results/new.xml
  def new
    @result = Result.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @result }
    end
  end

  # GET /results/1/edit
  def edit
    @result = Result.find(params[:id])
  end

  # POST /results
  # POST /results.xml
  def create
    @result = Result.new(params[:result])

    respond_to do |format|
      if @result.save
        flash[:notice] = 'Result was successfully created.'
        format.html { redirect_to(@result) }
        format.xml  { render :xml => @result, :status => :created, :location => @result }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /results/1
  # PUT /results/1.xml
  def update
    @result = Result.find(params[:id])

    respond_to do |format|
      if @result.update_attributes(params[:result])
        flash[:notice] = 'Result was successfully updated.'
        format.html { redirect_to(@result) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.xml
  def destroy


    @result = Result.find(params[:id])
    if @result.user_id == current_user.id || current_user.is_idem_admin
      @result.destroy
    end

    respond_to do |format|
      format.html { redirect_to(results_url) }
      format.xml  { head :ok }
      format.js {
        render :update do |pg|
          pg.replace_html "result_#{@result.id}", ""
        end
      }
    end
  end
  
  def diploma
    @result = Result.find(params[:id])
    @run = @result.run  
    @diploma_schema = @run.diploma_schema
    
    if @diploma_schema
    
      @diploma_elements = @diploma_schema.diploma_elements
      render :layout => false
      
    else
      
      # diploma schema not yet created
      render :text => "<br/><br/><br/><br/><center><b>El diploma aún no fue creado.</b><br/>En los proximos dias estará listo su diploma.</center><br/><br/><br/><br/>"
      
    end
    
    
  end
  
  def multiresult
    @run = Run.find(params[:id])
  end
  
  def forced_proceed
    Filesupload.excel_result_forced(params[:file], params[:id].to_i)
    render :nothing => true
  end
  
  def upload_data
    @head = Filesupload.excel_for_results(params[:upload], params[:id].to_i)
    #@run = Run.find(2)
    #render :action =>  'blabla'
    #redirect_to :action => 'index'
    
    render :nothing => true
    
  end
end
