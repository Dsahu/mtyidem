class RunsController < ApplicationController

  before_filter :admin_required, :except => ['show']

  # GET /runs
  # GET /runs.xml
  def index
    @runs = Run.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @runs }
    end
  end

  # GET /runs/1
  # GET /runs/1.xml
  def show
    @run = Run.find(params[:id])
    @convocatoriaunits = @run.convocatoriaunits
    @runtypes = Runtype.all
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @run }
      format.js   { 
        if params[:mode] && params[:mode] == "convocatoria"
          render :action => 'convocatoria', :layout => false 
        end
      }
    end
  end

  # GET /runs/new
  # GET /runs/new.xml
  def new
    @run = Run.new
    @runtypes = Runtype.all
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @run }
    end
  end

  # GET /runs/1/edit
  def edit
    @run = Run.find(params[:id])
    @runtypes = Runtype.all
    
    respond_to do |format|
      format.html # edit.html.erb
      format.js   { render :action => 'forboxy', :layout => false }
    end
  end

  # POST /runs
  # POST /runs.xml
  def create
    @run = Run.new(params[:run])

    respond_to do |format|
      if @run.save
        flash[:notice] = 'Run was successfully created.'
        format.html { redirect_to(@run) }
        format.xml  { render :xml => @run, :status => :created, :location => @run }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @run.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /runs/1
  # PUT /runs/1.xml
  def update
    @run = Run.find(params[:id])

    respond_to do |format|
      if @run.update_attributes(params[:run])
        flash[:notice] = 'Run was successfully updated.'
        format.html { redirect_to(@run) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @run.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /runs/1
  # DELETE /runs/1.xml
  def destroy
    @run = Run.find(params[:id])
    @run.destroy

    respond_to do |format|
      format.html { redirect_to(runs_url) }
      format.xml  { head :ok }
    end
  end
end
