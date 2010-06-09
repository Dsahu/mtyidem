class WalleventsController < ApplicationController
  # GET /wallevents
  # GET /wallevents.xml
  def index
    @wallevents = Wallevent.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wallevents }
    end
  end

  # GET /wallevents/1
  # GET /wallevents/1.xml
  def show
    @wallevent = Wallevent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wallevent }
    end
  end

  # GET /wallevents/new
  # GET /wallevents/new.xml
  def new
    @wallevent = Wallevent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wallevent }
    end
  end

  # GET /wallevents/1/edit
  def edit
    @wallevent = Wallevent.find(params[:id])
  end

  # POST /wallevents
  # POST /wallevents.xml
  def create
    @wallevent = Wallevent.new(params[:wallevent])

    respond_to do |format|
      if @wallevent.save
        flash[:notice] = 'Wallevent was successfully created.'
        format.html { redirect_to(@wallevent) }
        format.xml  { render :xml => @wallevent, :status => :created, :location => @wallevent }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wallevent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wallevents/1
  # PUT /wallevents/1.xml
  def update
    @wallevent = Wallevent.find(params[:id])

    respond_to do |format|
      if @wallevent.update_attributes(params[:wallevent])
        flash[:notice] = 'Wallevent was successfully updated.'
        format.html { redirect_to(@wallevent) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wallevent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wallevents/1
  # DELETE /wallevents/1.xml
  def destroy
    @wallevent = Wallevent.find(params[:id])
    @wallevent.destroy

    respond_to do |format|
      format.html { redirect_to(wallevents_url) }
      format.xml  { head :ok }
    end
  end
end
