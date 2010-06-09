class OrganizatorsController < ApplicationController
  # GET /organizators
  # GET /organizators.xml
  def index
    @organizators = Organizator.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @organizators }
    end
  end

  # GET /organizators/1
  # GET /organizators/1.xml
  def show
    @organizator = Organizator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @organizator }
    end
  end

  # GET /organizators/new
  # GET /organizators/new.xml
  def new
    @organizator = Organizator.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @organizator }
    end
  end

  # GET /organizators/1/edit
  def edit
    @organizator = Organizator.find(params[:id])
  end

  # POST /organizators
  # POST /organizators.xml
  def create
    @organizator = Organizator.new(params[:organizator])

    respond_to do |format|
      if @organizator.save
        flash[:notice] = 'Organizator was successfully created.'
        format.html { redirect_to(@organizator) }
        format.xml  { render :xml => @organizator, :status => :created, :location => @organizator }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @organizator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /organizators/1
  # PUT /organizators/1.xml
  def update
    @organizator = Organizator.find(params[:id])

    respond_to do |format|
      if @organizator.update_attributes(params[:organizator])
        flash[:notice] = 'Organizator was successfully updated.'
        format.html { redirect_to(@organizator) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @organizator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /organizators/1
  # DELETE /organizators/1.xml
  def destroy
    @organizator = Organizator.find(params[:id])
    @organizator.destroy

    respond_to do |format|
      format.html { redirect_to(organizators_url) }
      format.xml  { head :ok }
    end
  end
end
