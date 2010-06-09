class VideocommentsController < ApplicationController
  
  before_filter :login_required
  
  # GET /videocomments
  # GET /videocomments.xml
  def index
    @videocomments = Videocomment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @videocomments }
    end
  end

  # GET /videocomments/1
  # GET /videocomments/1.xml
  def show
    @videocomment = Videocomment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @videocomment }
    end
  end

  # GET /videocomments/new
  # GET /videocomments/new.xml
  def new
    @videocomment = Videocomment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @videocomment }
    end
  end

  # GET /videocomments/1/edit
  def edit
    @videocomment = Videocomment.find(params[:id])
  end

  # POST /videocomments
  # POST /videocomments.xml
  def create
    
    @videocomment = Videocomment.new(params[:videocomment])
    @videocomment.user_id = current_user.id

    respond_to do |format| 
      if @videocomment.save
        flash[:notice] = 'Videocomment was successfully created.'
        format.html { redirect_to(@videocomment) }
        format.xml  { render :xml => @videocomment, :status => :created, :location => @videocomment }
        format.js   { render :update do |page| 
             page.insert_html :bottom, 'videocomments', :partial => 'one_comment', :locals => {:videocomment => @videocomment}
             #page.visual_effect(:highlight, 'videocomment_'+@videocomment.id.to_s)
          end
        }
       
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @videocomment.errors, :status => :unprocessable_entity }
        format.js   { render :text => "0"}
      end
    end
  end

  # PUT /videocomments/1
  # PUT /videocomments/1.xml
  def update
    @videocomment = Videocomment.find(params[:id])

    respond_to do |format|
      if @videocomment.update_attributes(params[:videocomment])
        flash[:notice] = 'Videocomment was successfully updated.'
        format.html { redirect_to(@videocomment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @videocomment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /videocomments/1
  # DELETE /videocomments/1.xml
  def destroy
    @videocomment = Videocomment.find(params[:id])
    @videocomment.destroy

    respond_to do |format|
      format.html { redirect_to(videocomments_url) }
      format.xml  { head :ok }
    end
  end
end
