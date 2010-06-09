class PaycondsController < ApplicationController
  # GET /payconds
  # GET /payconds.xml
  def index
    @payconds = Paycond.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @payconds }
    end
  end

  # GET /payconds/1
  # GET /payconds/1.xml
  def show
    @paycond = Paycond.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @paycond }
    end
  end

  # GET /payconds/new
  # GET /payconds/new.xml
  def new
    @paycond = Paycond.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @paycond }
    end
  end

  # GET /payconds/1/edit
  def edit
    @paycond = Paycond.find(params[:id])
  end

  # POST /payconds
  # POST /payconds.xml
  def create
    @paycond = Paycond.new(params[:paycond])

    respond_to do |format|
      if @paycond.save
        flash[:notice] = 'Paycond was successfully created.'
        format.html { redirect_to(@paycond) }
        format.xml  { render :xml => @paycond, :status => :created, :location => @paycond }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @paycond.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /payconds/1
  # PUT /payconds/1.xml
  def update
    @paycond = Paycond.find(params[:id])

    respond_to do |format|
      if @paycond.update_attributes(params[:paycond])
        flash[:notice] = 'Paycond was successfully updated.'
        format.html { redirect_to(@paycond) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @paycond.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /payconds/1
  # DELETE /payconds/1.xml
  def destroy
    @paycond = Paycond.find(params[:id])
    @paycond.destroy

    respond_to do |format|
      format.html { redirect_to(payconds_url) }
      format.xml  { head :ok }
    end
  end
end
