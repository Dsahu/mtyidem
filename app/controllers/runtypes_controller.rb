class RuntypesController < ApplicationController
  # GET /runtypes
  # GET /runtypes.xml
  def index
    @runtypes = Runtype.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @runtypes }
    end
  end

  # GET /runtypes/1
  # GET /runtypes/1.xml
  def show
    @runtype = Runtype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @runtype }
    end
  end

  # GET /runtypes/new
  # GET /runtypes/new.xml
  def new
    @runtype = Runtype.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @runtype }
    end
  end

  # GET /runtypes/1/edit
  def edit
    @runtype = Runtype.find(params[:id])
  end

  # POST /runtypes
  # POST /runtypes.xml
  def create
    @runtype = Runtype.new(params[:runtype])

    respond_to do |format|
      if @runtype.save
        flash[:notice] = 'Runtype was successfully created.'
        format.html { redirect_to(@runtype) }
        format.xml  { render :xml => @runtype, :status => :created, :location => @runtype }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @runtype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /runtypes/1
  # PUT /runtypes/1.xml
  def update
    @runtype = Runtype.find(params[:id])

    respond_to do |format|
      if @runtype.update_attributes(params[:runtype])
        flash[:notice] = 'Runtype was successfully updated.'
        format.html { redirect_to(@runtype) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @runtype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /runtypes/1
  # DELETE /runtypes/1.xml
  def destroy
    @runtype = Runtype.find(params[:id])
    @runtype.destroy

    respond_to do |format|
      format.html { redirect_to(runtypes_url) }
      format.xml  { head :ok }
    end
  end
end
