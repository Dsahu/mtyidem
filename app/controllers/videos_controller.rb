class VideosController < ApplicationController
  
  layout 'application'
  
  # GET /videos
  # GET /videos.xml
  def index
    
    unless params[:run]
      #@runs = Run.find(:all, :conditions => {:showvideos => true})

      # INIT

      @today = Date.today
      @year = (params[:year].to_s.to_i > 0 ? @year = params[:year].to_i : @year = @today.year)
      @runs = Run.find(:all, :conditions => ["showvideos = 1 and year(eventday) = ?", @year], :order => "eventday desc")

     # PAST RUNS

      @pr_ar = []

      @runs.each do |run|

        actual_month = run.eventday.month
        @pr_ar[actual_month] ||= [] # INIT if necesarry
        @pr_ar[actual_month] << run

      end

      @pr_ar.reverse!.compact!



      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @videos }
      end
    end
    
    if params[:run] && params[:run].to_i > 0
      @run = Run.find(params[:run].to_i)
      @video = Video.find(:first, :conditions => {:run_id => @run.id}, :order => "name desc")
      
      redirect_to(:controller => :videos, :action => :show, :id => @video.id)
      
    end
    
  end

  # GET /videos/1
  # GET /videos/1.xml
  def show
    @video = Video.find(params[:id])
    @run = Run.find(@video.run_id)
    @videos = @run.visiblevideos
    @video.counter += 1
    @video.save
    
    @videocomments = Videocomment.find(:all, :conditions => {:video_id => @video.id})
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @video }
    end
  end

  # GET /videos/new
  # GET /videos/new.xml
  def new
    @video = Video.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @video }
    end
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end

  # POST /videos
  # POST /videos.xml
  def create
    @video = Video.new(params[:video])

    respond_to do |format|
      if @video.save
        flash[:notice] = 'Video was successfully created.'
        format.html { redirect_to(@video) }
        format.xml  { render :xml => @video, :status => :created, :location => @video }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.xml
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        flash[:notice] = 'Video was successfully updated.'
        format.html { redirect_to(@video) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.xml
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to(videos_url) }
      format.xml  { head :ok }
    end
  end
end
