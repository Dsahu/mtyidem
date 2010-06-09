class DiplomaSchemasController < ApplicationController
  # GET /diploma_schemas
  # GET /diploma_schemas.xml
  def index
    @diploma_schemas = DiplomaSchema.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @diploma_schemas }
    end
  end

  # GET /diploma_schemas/1
  # GET /diploma_schemas/1.xml
  def show
    @diploma_schema = DiplomaSchema.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @diploma_schema }
    end
  end

  # GET /diploma_schemas/new
  # GET /diploma_schemas/new.xml
  def new
    @diploma_schema = DiplomaSchema.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @diploma_schema }
    end
  end

  # GET /diploma_schemas/1/edit
  def edit
    @diploma_schema = DiplomaSchema.find(params[:id])
    @diploma_elements = @diploma_schema.diploma_elements
    @run = @diploma_schema.run
  end

  # POST /diploma_schemas
  # POST /diploma_schemas.xml
  def create
    @diploma_schema = DiplomaSchema.new(params[:diploma_schema])
    

    respond_to do |format|
      if @diploma_schema.save
        flash[:notice] = 'DiplomaSchema was successfully created.'
        format.html { redirect_to(@diploma_schema) }
        format.xml  { render :xml => @diploma_schema, :status => :created, :location => @diploma_schema }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @diploma_schema.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /diploma_schemas/1
  # PUT /diploma_schemas/1.xml
  def update
    @diploma_schema = DiplomaSchema.find(params[:id])

    @diploma_elements = @diploma_schema.diploma_elements
    @diploma_elements.each {|x| x.destroy }
    @diploma_elements = []
    
    (0..(params[:elementcount].to_i-1)).each do |idx|
      dip_el = DiplomaElement.new(:column_name => params[:"#{idx.to_s}_column_name"],
                                  :diploma_schema_id => @diploma_schema.id,
                                  :pos_x => params[:"#{idx.to_s}_pos_x"],
                                  :pos_y => params[:"#{idx.to_s}_pos_y"],
                                  :font_family => params[:"#{idx.to_s}_font_family"],
                                  :font_size => params[:"#{idx.to_s}_font_size"])
                                  
      dip_el.save
    end

    respond_to do |format|
      if @diploma_schema.update_attributes(params[:diploma_schema])
        flash[:notice] = 'DiplomaSchema was successfully updated.'
        format.html { redirect_to(@diploma_schema) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @diploma_schema.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /diploma_schemas/1
  # DELETE /diploma_schemas/1.xml
  def destroy
    @diploma_schema = DiplomaSchema.find(params[:id])
    @diploma_schema.destroy

    respond_to do |format|
      format.html { redirect_to(diploma_schemas_url) }
      format.xml  { head :ok }
    end
  end
end
