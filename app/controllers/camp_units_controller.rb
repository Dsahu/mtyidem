class CampUnitsController < ApplicationController
  # GET /camp_units
  # GET /camp_units.xml
  def index
    @camp_units = CampUnit.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @camp_units }
    end
  end

  # GET /camp_units/1
  # GET /camp_units/1.xml
  def show
    @camp_unit = CampUnit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @camp_unit }
    end
  end

  # GET /camp_units/new
  # GET /camp_units/new.xml
  def new
    @camp_unit = CampUnit.new
    @camp_unit.campaign_id = params[:campaign_id] if params[:campaign_id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @camp_unit }
      format.js { render(:action => :new, :layout => false) }
    end
  end

  # GET /camp_units/1/edit
  def edit
    
    if params[:id].to_i > 0
    
      @camp_unit = CampUnit.find(params[:id])
      respond_to do |format|
        format.js { render :action => :edit, :layout => false }
      end
    
    else
      render :nothing => true
    end
    
  end

  # POST /camp_units
  # POST /camp_units.xml
  def create
    @camp_unit = CampUnit.new(params[:camp_unit])
    @camp_unit.path = Filesupload.camp_unit_pic(params[:upload]) if params[:upload] && params[:upload]['datafile'].original_filename.length > 0

    respond_to do |format|
      if @camp_unit.save
        flash[:notice] = 'CampUnit was successfully created.'
        format.html { redirect_to(@camp_unit.campaign) }
        format.xml  { render :xml => @camp_unit, :status => :created, :location => @camp_unit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @camp_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /camp_units/1
  # PUT /camp_units/1.xml
  def update
    @camp_unit = CampUnit.find(params[:id])
    @camp_unit.path = Filesupload.camp_unit_pic(params[:upload]) if params[:upload] && params[:upload]['datafile'].original_filename.length > 0


    respond_to do |format|
      if @camp_unit.update_attributes(params[:camp_unit])
        flash[:notice] = 'CampUnit was successfully updated.'
        format.html { redirect_to(@camp_unit.campaign) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @camp_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /camp_units/1
  # DELETE /camp_units/1.xml
  def destroy
    @camp_unit = CampUnit.find(params[:id])
    @camp_unit.destroy

    respond_to do |format|
      format.html { redirect_to(camp_units_url) }
      format.xml  { head :ok }
    end
  end
end
