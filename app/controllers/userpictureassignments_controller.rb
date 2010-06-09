class UserpictureassignmentsController < ApplicationController

  before_filter :admin_required, :except => [:create, :update]

  # GET /userpictureassignments
  # GET /userpictureassignments.xml
  def index
    @userpictureassignments = Userpictureassignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @userpictureassignments }
    end
  end

  # GET /userpictureassignments/1
  # GET /userpictureassignments/1.xml
  def show
    @userpictureassignment = Userpictureassignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @userpictureassignment }
    end
  end

  # GET /userpictureassignments/new
  # GET /userpictureassignments/new.xml
  def new
    @userpictureassignment = Userpictureassignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @userpictureassignment }
    end
  end

  # GET /userpictureassignments/1/edit
  def edit
    @userpictureassignment = Userpictureassignment.find(params[:id])
  end

  # POST /userpictureassignments
  # POST /userpictureassignments.xml
  def create
    @userpictureassignment = Userpictureassignment.new(params[:userpictureassignment])
    
    @old_assigns = Userpictureassignment.find(:all, :conditions => {:picture_id => @userpictureassignment.picture_id, :user_id => @userpictureassignment.user_id})
    
    if @old_assigns.count == 0 && @userpictureassignment.cor_x && @userpictureassignment.cor_y && @userpictureassignment.picture_id
      @userpictureassignment.tagged_by_user_id = current_user.id
      
      respond_to do |format|
        if @userpictureassignment.save
          format.html { redirect_to(@userpictureassignment) }
          format.xml  { render :xml => @userpictureassignment, :status => :created, :location => @userpictureassignment }
          format.js   { 
            user = @userpictureassignment.user
            
            render :text => @userpictureassignment.user.to_json(:only => [:id, :firstname, :lastname, :profile_path, :profilepic])
          
          }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @userpictureassignment.errors, :status => :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.js     { render :text => "Error" }
      end
    end
  end

  # PUT /userpictureassignments/1
  # PUT /userpictureassignments/1.xml
  def update
    @userpictureassignment = Userpictureassignment.find(params[:id])

    respond_to do |format|
      if @userpictureassignment.update_attributes(params[:userpictureassignment])
        flash[:notice] = 'Userpictureassignment was successfully updated.'
        format.html { redirect_to(@userpictureassignment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @userpictureassignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /userpictureassignments/1
  # DELETE /userpictureassignments/1.xml
  def destroy
    @userpictureassignment = Userpictureassignment.find(params[:id])
    @userpictureassignment.destroy

    respond_to do |format|
      format.html { redirect_to(userpictureassignments_url) }
      format.xml  { head :ok }
    end
  end
end
