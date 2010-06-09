class UservideoassignmentsController < ApplicationController
  # GET /uservideoassignments
  # GET /uservideoassignments.xml
  def index
    @uservideoassignments = Uservideoassignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @uservideoassignments }
    end
  end

  # GET /uservideoassignments/1
  # GET /uservideoassignments/1.xml
  def show
    @uservideoassignment = Uservideoassignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @uservideoassignment }
    end
  end

  # GET /uservideoassignments/new
  # GET /uservideoassignments/new.xml
  def new
    @uservideoassignment = Uservideoassignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @uservideoassignment }
    end
  end

  # GET /uservideoassignments/1/edit
  def edit
    @uservideoassignment = Uservideoassignment.find(params[:id])
  end

  # POST /uservideoassignments
  # POST /uservideoassignments.xml
  def create
    
    @uservideoassignment = Uservideoassignment.new(params[:uservideoassignment])
    @uservideoassignment.tagged_by_user_id = current_user.id if current_user

    respond_to do |format|
      if @uservideoassignment.save
        flash[:notice] = 'Uservideoassignment was successfully created.'
        format.html { redirect_to(@uservideoassignment) }
        format.xml  { render :xml => @uservideoassignment, :status => :created, :location => @uservideoassignment }
        format.js   { render :text => "<span style='color:gray;'>Agregado al Video</span>" }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @uservideoassignment.errors, :status => :unprocessable_entity }
        format.js   { render :text => "<span style='color:red;'>Un error occurió</span>" }
      end
    end
  end

  # PUT /uservideoassignments/1
  # PUT /uservideoassignments/1.xml
  def update
    @uservideoassignment = Uservideoassignment.find(params[:id])

    respond_to do |format|
      if @uservideoassignment.update_attributes(params[:uservideoassignment])
        flash[:notice] = 'Uservideoassignment was successfully updated.'
        format.html { redirect_to(@uservideoassignment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @uservideoassignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /uservideoassignments/1
  # DELETE /uservideoassignments/1.xml
  def destroy
    @uservideoassignment = Uservideoassignment.find(params[:id])
    @uservideoassignment.destroy

    respond_to do |format|
      format.html { redirect_to(uservideoassignments_url) }
      format.xml  { head :ok }
    end
  end
end
