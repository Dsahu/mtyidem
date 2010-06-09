class RuneventsController < ApplicationController
  # GET /runevents
  # GET /runevents.xml
  def index
    @runevents = Runevent.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @runevents }
    end
  end

  # GET /runevents/1
  # GET /runevents/1.xml
  def show
    @runevent = Runevent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @runevent }
    end
  end

  # GET /runevents/new
  # GET /runevents/new.xml
  def new
    @runevent = Runevent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @runevent }
    end
  end

  # GET /runevents/1/edit
  def edit
    @runevent = Runevent.find(params[:id])
  end

  # POST /runevents
  # POST /runevents.xml
  def create
    @runevent = Runevent.new(params[:runevent])

    respond_to do |format|
      if @runevent.save
        flash[:notice] = 'Runevent was successfully created.'
        format.html { redirect_to(@runevent) }
        format.xml  { render :xml => @runevent, :status => :created, :location => @runevent }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @runevent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /runevents/1
  # PUT /runevents/1.xml
  def update
    @runevent = Runevent.find(params[:id])

    respond_to do |format|
      if @runevent.update_attributes(params[:runevent])
        flash[:notice] = 'Runevent was successfully updated.'
        format.html { redirect_to(@runevent) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @runevent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /runevents/1
  # DELETE /runevents/1.xml
  def destroy
    @runevent = Runevent.find(params[:id])
    @runevent.destroy

    respond_to do |format|
      format.html { redirect_to(runevents_url) }
      format.xml  { head :ok }
    end
  end
end
