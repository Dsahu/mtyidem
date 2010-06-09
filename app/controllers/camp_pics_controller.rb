class CampPicsController < ApplicationController
  # GET /camp_pics
  # GET /camp_pics.xml
  def index
    @camp_pics = CampPic.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @camp_pics }
    end
  end

  # GET /camp_pics/1
  # GET /camp_pics/1.xml
  def show
    @camp_pic = CampPic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @camp_pic }
    end
  end

  # GET /camp_pics/new
  # GET /camp_pics/new.xml
  def new
    @camp_pic = CampPic.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @camp_pic }
    end
  end

  # GET /camp_pics/1/edit
  def edit
    @camp_pic = CampPic.find(params[:id])
  end

  # POST /camp_pics
  # POST /camp_pics.xml
  def create
    @camp_pic = CampPic.new(params[:camp_pic])
    @camp_pic.path = Filesupload.camp_pic(params[:upload])
    
    respond_to do |format|
      if @camp_pic.save
        #flash[:notice] = 'CampPic was successfully created.'
        format.html { redirect_to(@camp_pic.campaign) }
        format.xml  { render :xml => @camp_pic, :status => :created, :location => @camp_pic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @camp_pic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /camp_pics/1
  # PUT /camp_pics/1.xml
  def update
    @camp_pic = CampPic.find(params[:id])

    respond_to do |format|
      if @camp_pic.update_attributes(params[:camp_pic])
        flash[:notice] = 'CampPic was successfully updated.'
        format.html { redirect_to(@camp_pic) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @camp_pic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /camp_pics/1
  # DELETE /camp_pics/1.xml
  def destroy
    @camp_pic = CampPic.find(params[:id])
    @camp_pic.destroy

    respond_to do |format|
      format.html { redirect_to(camp_pics_url) }
      format.xml  { head :ok }
    end
  end
end
