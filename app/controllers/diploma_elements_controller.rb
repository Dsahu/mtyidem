class DiplomaElementsController < ApplicationController
  # GET /diploma_elements
  # GET /diploma_elements.xml
  def index
    @diploma_elements = DiplomaElement.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @diploma_elements }
    end
  end

  # GET /diploma_elements/1
  # GET /diploma_elements/1.xml
  def show
    @diploma_element = DiplomaElement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @diploma_element }
    end
  end

  # GET /diploma_elements/new
  # GET /diploma_elements/new.xml
  def new
    @diploma_element = DiplomaElement.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @diploma_element }
    end
  end

  # GET /diploma_elements/1/edit
  def edit
    @diploma_element = DiplomaElement.find(params[:id])
  end

  # POST /diploma_elements
  # POST /diploma_elements.xml
  def create
    @diploma_element = DiplomaElement.new(params[:diploma_element])

    respond_to do |format|
      if @diploma_element.save
        flash[:notice] = 'DiplomaElement was successfully created.'
        format.html { redirect_to(@diploma_element) }
        format.xml  { render :xml => @diploma_element, :status => :created, :location => @diploma_element }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @diploma_element.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /diploma_elements/1
  # PUT /diploma_elements/1.xml
  def update
    @diploma_element = DiplomaElement.find(params[:id])

    respond_to do |format|
      if @diploma_element.update_attributes(params[:diploma_element])
        flash[:notice] = 'DiplomaElement was successfully updated.'
        format.html { redirect_to(@diploma_element) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @diploma_element.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /diploma_elements/1
  # DELETE /diploma_elements/1.xml
  def destroy
    @diploma_element = DiplomaElement.find(params[:id])
    @diploma_element.destroy

    respond_to do |format|
      format.html { redirect_to(diploma_elements_url) }
      format.xml  { head :ok }
    end
  end
end
