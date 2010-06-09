class PicturesController < ApplicationController
  
  layout 'application'
  before_filter :admin_required, :except => ['index', 'comments_form', 'tags']
  
  # GET /pictures
  # GET /pictures.xml
  def index
    unless params[:run]
     
      # INIT

      @today = Date.today
      @year = (params[:year].to_s.to_i > 0 ? @year = params[:year].to_i : @year = @today.year)
      @runs = Run.find(:all, :conditions => ["showphotos = 1 and year(eventday) = ?", @year], :order => "eventday desc")

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
      end
    end
    
    if params[:run] && params[:run].to_i > 0
      @run = Run.find(params[:run].to_i)
      @pictures = Picture.find(:all, :conditions => {:run_id => @run.id}, :order => "path asc")
      
      params[:picture_id] ? @pictures.each { |pic| @first_picture = pic if pic.id == params[:picture_id].to_i } : @first_picture = @pictures.first
      
      @friends = current_user.friends(true) if current_user
      @users = []
      if @first_picture
        @first_pic_picturecomments = Picturecomment.find(:all, :conditions => {:picture_id => @pictures.first.id})
      else
        @first_pic_picturecomments = []
      end
      
      if @pictures.count > 0
        respond_to do |format|
          format.html { render :action => 'rungallery'}
          format.xml  { render :xml => @pictures }
        end
      else
        redirect_to(:controller => 'pictures', :action => 'index')
      end
    end
  end

  def comments_form
    respond_to do |format|
      format.js {
        @picture = Picture.find(params[:id])
        @picturecomments = Picturecomment.find(:all, :conditions => {:picture_id => params[:id]})
        render :layout => false, :partial => 'picture_comment_form', :locals => {:picturecomments => @picturecomments, :picture => @picture}
        #render :update do |page|
        #  page.replace_html "picturecomments", :partial => 'picture_comment_form', :locals => {:picturecomments => @picturecomments}
        #end
      }
    end
  end

  def tags
    respond_to do |format|
      format.json {
        @picture = Picture.find(params[:id])
        @users = @picture.users
        @userpictureassignments = @picture.userpictureassignments
        
        @users.map! { |u| [u.id, u.firstname, u.lastname, u.profile_path, u.profilepic, ((@userpictureassignments.map {|upa| upa.user_id == u.id ? upa.cor_x : nil }.compact.first) ? (@userpictureassignments.map {|upa| upa.user_id == u.id ? upa.cor_x : nil }.compact.first) : 0), ((@userpictureassignments.map {|upa| upa.user_id == u.id ? upa.cor_y : nil }.compact.first) ? (@userpictureassignments.map {|upa| upa.user_id == u.id ? upa.cor_y : nil }.compact.first) : 0)]}.uniq!
        render :json => @users
      }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.xml
  def show
    @picture = Picture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @picture }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.xml
  def new
    @picture = Picture.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
    @picture = Picture.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.xml
  def create
    @picture = Picture.new(params[:picture])

    respond_to do |format|
      if @picture.save
        flash[:notice] = 'Picture was successfully created.'
        format.html { redirect_to(@picture) }
        format.xml  { render :xml => @picture, :status => :created, :location => @picture }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.xml
  def update
    @picture = Picture.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        flash[:notice] = 'Picture was successfully updated.'
        format.html { redirect_to(@picture) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.xml
  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to(pictures_url) }
      format.xml  { head :ok }
    end
  end
end
