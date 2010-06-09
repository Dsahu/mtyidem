class PicturecommentsController < ApplicationController
  # GET /picturecomments
  # GET /picturecomments.xml
  def index
    @picturecomments = Picturecomment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @picturecomments }
    end
  end

  # GET /picturecomments/1
  # GET /picturecomments/1.xml
  def show

    @picturecomment = Picturecomment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @picturecomment }
    end
  end

  # GET /picturecomments/new
  # GET /picturecomments/new.xml
  def new
    @picturecomment = Picturecomment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @picturecomment }
    end
  end

  # GET /picturecomments/1/edit
  def edit
    @picturecomment = Picturecomment.find(params[:id])
  end

  # POST /picturecomments
  # POST /picturecomments.xml
  def create
    @picturecomment = Picturecomment.new(params[:picturecomment])
    @picturecomment.user_id = current_user.id

    respond_to do |format|
      if @picturecomment.save
        flash[:notice] = 'Picturecomment was successfully created.'
        format.html { redirect_to(@picturecomment) }
        format.xml  { render :xml => @picturecomment, :status => :created, :location => @picturecomment }
        format.js   { render :update do |page| 
            page.insert_html :bottom, 'picturecomments', :partial => 'one_comment', :locals => {:picturecomment => @picturecomment} 
            # lba bla bla
          end
        } 
        
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @picturecomment.errors, :status => :unprocessable_entity }
        format.js   { render :js => "alert(1);"}
      end
    end
  end

  # PUT /picturecomments/1
  # PUT /picturecomments/1.xml
  def update
    @picturecomment = Picturecomment.find(params[:id])

    respond_to do |format|
      if @picturecomment.update_attributes(params[:picturecomment])
        flash[:notice] = 'Picturecomment was successfully updated.'
        format.html { redirect_to(@picturecomment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @picturecomment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /picturecomments/1
  # DELETE /picturecomments/1.xml
  def destroy
    @picturecomment = Picturecomment.find(params[:id])
    @picturecomment.destroy

    respond_to do |format|
      format.html { redirect_to(picturecomments_url) }
      format.xml  { head :ok }
    end
  end
end
