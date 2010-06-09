class RunnerCategoriesController < ApplicationController

  before_filter :admin_required

  # GET /runner_categories
  # GET /runner_categories.xml
  def index
    @runner_categories = RunnerCategory.find(:all, :include => :run)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @runner_categories }
    end
  end

  # GET /runner_categories/1
  # GET /runner_categories/1.xml
  def show
    @runner_category = RunnerCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @runner_category }
    end
  end

  # GET /runner_categories/new
  # GET /runner_categories/new.xml
  def new
    @runner_category = RunnerCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @runner_category }
    end
  end

  # GET /runner_categories/1/edit
  def edit
    @runner_category = RunnerCategory.find(params[:id])
  end

  # POST /runner_categories
  # POST /runner_categories.xml
  def create
    @runner_category = RunnerCategory.new(params[:runner_category])

    respond_to do |format|
      if @runner_category.save
        flash[:notice] = 'RunnerCategory was successfully created.'
        format.html { redirect_to(@runner_category) }
        format.xml  { render :xml => @runner_category, :status => :created, :location => @runner_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @runner_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /runner_categories/1
  # PUT /runner_categories/1.xml
  def update
    @runner_category = RunnerCategory.find(params[:id])

    respond_to do |format|
      if @runner_category.update_attributes(params[:runner_category])
        flash[:notice] = 'RunnerCategory was successfully updated.'
        format.html { redirect_to(@runner_category) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @runner_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /runner_categories/1
  # DELETE /runner_categories/1.xml
  def destroy
    @runner_category = RunnerCategory.find(params[:id])
    @runner_category.destroy

    respond_to do |format|
      format.html { redirect_to(runner_categories_url) }
      format.xml  { head :ok }
    end
  end
end
