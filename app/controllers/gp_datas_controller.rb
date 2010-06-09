class GpDatasController < ApplicationController
  # GET /gp_datas
  # GET /gp_datas.xml
  def index
    @gp_datas = GpData.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @gp_datas }
    end
  end

  # GET /gp_datas/1
  # GET /gp_datas/1.xml
  def show
    @gp_data = GpData.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gp_data }
    end
  end

  # GET /gp_datas/new
  # GET /gp_datas/new.xml
  def new
    @gp_data = GpData.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @gp_data }
    end
  end

  # GET /gp_datas/1/edit
  def edit
    @gp_data = GpData.find(params[:id])
  end

  # POST /gp_datas
  # POST /gp_datas.xml
  def create
    @gp_data = GpData.new(params[:gp_data])

    respond_to do |format|
      if @gp_data.save
        flash[:notice] = 'GpData was successfully created.'
        format.html { redirect_to(@gp_data) }
        format.xml  { render :xml => @gp_data, :status => :created, :location => @gp_data }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gp_data.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /gp_datas/1
  # PUT /gp_datas/1.xml
  def update
    @gp_data = GpData.find(params[:id])

    respond_to do |format|
      if @gp_data.update_attributes(params[:gp_data])
        flash[:notice] = 'GpData was successfully updated.'
        format.html { redirect_to(@gp_data) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gp_data.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /gp_datas/1
  # DELETE /gp_datas/1.xml
  def destroy
    @gp_data = GpData.find(params[:id])
    @gp_data.destroy

    respond_to do |format|
      format.html { redirect_to(gp_datas_url) }
      format.xml  { head :ok }
    end
  end
end
