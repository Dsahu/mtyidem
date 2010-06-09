class FriendRequestsController < ApplicationController
  
  before_filter :login_required 
  before_filter :admin_required, :except => [:create, :accept, :ignore, :block]
  
  # GET /friend_requests
  # GET /friend_requests.xml
  def index
    @friend_requests = FriendRequest.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @friend_requests }
    end
  end

  def accept
    # AJAX ONLY
    @friendrequest = FriendRequest.find(params[:id])
    if @friendrequest.other_id == current_user.id
      @friendrequest.accept
      render :update do |page|
        page.visual_effect :highlight, "friend_request_6"
        page.replace_html "friend_request_6_content", "<i>Aceptado</i>"
      end
    else
      redirect_to(current_user.profile_path)
    end
  end

  def ignore
    # AJAX ONLY
    @friendrequest = FriendRequest.find(params[:id])
    if @friendrequest.other_id == current_user.id
      @friendrequest.ignore
      render :update do |page|
        page.visual_effect :highlight, "friend_request_6"
        page.replace_html "friend_request_6_content", "<i>Aceptado</i>"
      end
    else
      redirect_to(current_user.profile_path)
    end
  end

  def block
    # AJAX ONLY
    @friendrequest = FriendRequest.find(params[:id])
    if @friendrequest.other_id == current_user.id
      @friendrequest.block
      render :update do |page|
        page.visual_effect :highlight, "friend_request_6"
        page.replace_html "friend_request_6_content", "<i>Aceptado</i>"
      end
    else
      redirect_to(current_user.profile_path)
    end
  end

  # GET /friend_requests/1
  # GET /friend_requests/1.xml
  def show
    @friend_request = FriendRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @friend_request }
    end
  end

  # GET /friend_requests/new
  # GET /friend_requests/new.xml
  def new
    @friend_request = FriendRequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @friend_request }
    end
  end

  # GET /friend_requests/1/edit
  def edit
    @friend_request = FriendRequest.find(params[:id])
  end

  # POST /friend_requests
  # POST /friend_requests.xml
  def create
    @friend_request = FriendRequest.new(params[:friend_request])
    @friend_request.inviter_id = current_user.id
    @friend_request.status = FriendRequest::NEW
    
    # Check that there is no other open NEW friend request
    all_ok = true if FriendRequest.find(:all, :conditions => {:other_id => @friend_request.other_id, :inviter_id => @friend_request.inviter_id, :status => FriendRequest::NEW}).count == 0
    
    respond_to do |format|
      if @friend_request.save && all_ok
        flash[:notice] = 'FriendRequest was successfully created.'
        #format.html { redirect_to(@friend_request) }
        format.html { redirect_to(:controller => 'profile', :action => 'p', :id => @friend_request.other_id.to_s) }
        format.xml  { render :xml => @friend_request, :status => :created, :location => @friend_request }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @friend_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /friend_requests/1
  # PUT /friend_requests/1.xml
  def update
    @friend_request = FriendRequest.find(params[:id])

    respond_to do |format|
      if @friend_request.update_attributes(params[:friend_request])
        flash[:notice] = 'FriendRequest was successfully updated.'
        format.html { redirect_to(@friend_request) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @friend_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /friend_requests/1
  # DELETE /friend_requests/1.xml
  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy

    respond_to do |format|
      format.html { redirect_to(friend_requests_url) }
      format.xml  { head :ok }
    end
  end
end
