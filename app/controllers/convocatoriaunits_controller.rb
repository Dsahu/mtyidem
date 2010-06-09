class ConvocatoriaunitsController < ApplicationController
  # GET /convocatoriaunits
  # GET /convocatoriaunits.xml
  def index
    @convocatoriaunits = Convocatoriaunit.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @convocatoriaunits }
    end
  end

  # GET /convocatoriaunits/1
  # GET /convocatoriaunits/1.xml
  def show
    @convocatoriaunit = Convocatoriaunit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @convocatoriaunit }
    end
  end

  # GET /convocatoriaunits/new
  # GET /convocatoriaunits/new.xml
  def new
    @convocatoriaunit = Convocatoriaunit.new
    @runs = Run.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @convocatoriaunit }
    end
  end

  # GET /convocatoriaunits/1/edit
  def edit
    @convocatoriaunit = Convocatoriaunit.find(params[:id])
  end

  # POST /convocatoriaunits
  # POST /convocatoriaunits.xml
  def create
    @convocatoriaunit = Convocatoriaunit.new(params[:convocatoriaunit])

    respond_to do |format|
      if @convocatoriaunit.save
        flash[:notice] = 'Convocatoriaunit was successfully created.'
        format.html { redirect_to(@convocatoriaunit) }
        format.xml  { render :xml => @convocatoriaunit, :status => :created, :location => @convocatoriaunit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @convocatoriaunit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /convocatoriaunits/1
  # PUT /convocatoriaunits/1.xml
  def update
    @convocatoriaunit = Convocatoriaunit.find(params[:id])

    respond_to do |format|
      if @convocatoriaunit.update_attributes(params[:convocatoriaunit])
        flash[:notice] = 'Convocatoriaunit was successfully updated.'
        format.html { redirect_to(@convocatoriaunit) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @convocatoriaunit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /convocatoriaunits/1
  # DELETE /convocatoriaunits/1.xml
  def destroy
    @convocatoriaunit = Convocatoriaunit.find(params[:id])
    @convocatoriaunit.destroy

    respond_to do |format|
      format.html { redirect_to(convocatoriaunits_url) }
      format.xml  { head :ok }
    end
  end
end
