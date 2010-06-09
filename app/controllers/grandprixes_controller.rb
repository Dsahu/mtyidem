class GrandprixesController < ApplicationController
  
  layout 'application'
  
  before_filter :admin_required, :except => [:show, :search]
  
  #caches_page :show
  #cache_sweeper :grandprix_sweeper, :only => [:create, :update, :destroy]
  
  # GET /grandprixes
  # GET /grandprixes.xml
  def index
    @grandprixes = Grandprix.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @grandprixes }
    end
  end

  def search
    params[:search][:name].strip!
    @grandprix = Grandprix.find(params[:id])
    @gp_datas = GpData.find(:all, :conditions => ["grandprix_id = ? and instr(lcase(name), ?)", params[:id], params[:search][:name]], :order => "accum desc, name asc")
    render :update do |pg|

      pg.replace_html "gp_results", (render :partial => "results", :locals => {:gp_datas => @gp_datas, :grandprix => @grandprix})

    end
  end

  # GET /grandprixes/1
  # GET /grandprixes/1.xml
  def show
    
    @grandprix = Grandprix.find(params[:id])
    #@gp_datas = GpData.find(:all, :conditions => {:grandprix_id => @grandprix.id}, :order => "accum desc, name asc")
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @grandprix }
    end
  end

  # GET /grandprixes/new
  # GET /grandprixes/new.xml
  def new
    @grandprix = Grandprix.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @grandprix }
    end
  end

  # GET /grandprixes/1/edit
  def edit
    @grandprix = Grandprix.find(params[:id])
  end

  # POST /grandprixes
  # POST /grandprixes.xml
  def create
    @grandprix = Grandprix.new(params[:grandprix])

    respond_to do |format|
      if @grandprix.save
        format.html { redirect_to(@grandprix) }
        format.xml  { render :xml => @grandprix, :status => :created, :location => @grandprix }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @grandprix.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /grandprixes/1
  # PUT /grandprixes/1.xml
  def update
    @grandprix = Grandprix.find(params[:id])

    respond_to do |format|
      if @grandprix.update_attributes(params[:grandprix])
        format.html { redirect_to(@grandprix) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grandprix.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /grandprixes/1
  # DELETE /grandprixes/1.xml
  def destroy
    @grandprix = Grandprix.find(params[:id])
    @grandprix.destroy

    respond_to do |format|
      format.html { redirect_to(grandprixes_url) }
      format.xml  { head :ok }
    end
  end
end
