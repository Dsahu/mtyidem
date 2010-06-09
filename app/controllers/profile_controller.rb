class ProfileController < ApplicationController
  
  before_filter :login_required
  layout 'application'
  
  def index
    # the users own profile page
    
    redirect_to(:action => :p, :id => current_user.id)
    
  end
  
  def p
    # showing others profile page
    # params[:id] is the user.id or user.urlnickname
    
    @current_user = current_user
    
    #begin
      if params[:id] && params[:id].to_i > 0
        @user = User.find(params[:id])
      else
        ### URLNICKNAME check
        if params[:id] && params[:id].to_i == 0
          @user = User.find(:conditions => {:urlnickname => params[:id]})
          @user = current_user unless @user # in case that urlnickname is wrong...
        else
          # something wrong so @user = current_user
          @user = current_user
        end
      end
      @friends = @user.friends(true)
      @wallevents = @user.recent_wallevents(true)

      debugger

      @results = @user.results
      @picturegalleries = @user.pictures_as_album
      @friend_requests = @user.open_friend_requests
      @friend_requests_gotten = current_user.open_friend_requests
      
      render :action => 'index'
    #rescue
    #  redirect_to("/profile")
    #end
    
  end

  def comment
    @wallevent = Wallevent.new({
      :we_type => Wallevent::WALL_COMMENT,
      :user_id => params[:id],
      :otheruser_id => current_user.id,
      :description => params[:message].nl2br
    }).do_name
    @wallevent.save

    if params[:id].to_i != current_user.id
      @wallevent2 = Wallevent.new({
        :we_type => Wallevent::WALL_COMMENT_DONE,
        :user_id => current_user.id,
        :otheruser_id => params[:id]
      }).do_name
    @wallevent2.save
    end


    redirect_to "/profile/p/#{params[:id]}"

  end

  def wall_events
    @user = User.find(params[:id])
    @wallevents = @user.recent_wallevents
    
    render :update do |pg|
      pg.replace_html 'wall_content', :partial => 'wall', :locals => {:wallevents => @wallevents, :colormode => "", :event_response => true}
    end
  end
  
  def wall_fotos
    @user = User.find(params[:id])
    @picturegalleries = @user.pictures_as_album
    
    render :update do |pg|
      pg.replace_html 'wall_content', :partial => 'pictures', :locals => {:picturegalleries => @picturegalleries}
    end
  end
  
  def wall_videos
    @user = User.find(params[:id])
    @videos = Video.find(:all, :include => [:run, :uservideoassignments], :conditions => ["uservideoassignments.user_id = ?", @user.id])
    
    render :update do |pg|
      pg.replace_html 'wall_content', :partial => 'videos', :locals => {:videos => @videos}
    end
    
  end
  
  def wall_results
    @user = User.find(params[:id])
    @results = @user.results
    
    in_runs = @results.map {|r| r.run_id unless r.is_custom }.compact.join(",")

    unless in_runs.empty?
      run_totals = Result.find(:all, :select => "count(*) as total_res, run_id", :conditions => ["run_id in (?)", in_runs], :group => "run_id")

      cats_count = Hash.new
      cats_count_res = Result.find_by_sql("select cat, count(cat) as cat_count, run_id from results where run_id in (#{in_runs}) group by cat")
      cats_count_res.each { |cc| cats_count[:"#{cc.cat}"] = cc.cat_count }

      #res_count = Result.find_by_sql("select count(*) as total_count, run_id from results where run_id in (#{in_runs})")
      men_count = Result.find(:all, :select => "count(*) as men_count, run_id", :conditions => ["run_id in (?) AND instr(lcase(cat), 'm')", in_runs])
      women_count = Result.find(:all, :select => "count(*) as women_count, run_id", :conditions => ["run_id in (?) AND instr(lcase(cat), 'f')", in_runs])
    else
      run_totals = []
      cats_count_res = []
      men_count = []
      women_count = []
    end

    render :update do |pg|
      pg.replace_html 'wall_content', :partial => 'results', :locals => {:results => @results, :run_totals => run_totals, :cats_count_res => cats_count_res, :men_count => men_count, :women_count => women_count, :for_user => @user}
    end
  end

end