class StoreGroupsController < ApplicationController

  layout 'application'
  before_filter :admin_required

  # GET /strore_groups
  # GET /strore_groups.xml
  def index
    @store_groups = StoreGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @store_groups }
    end
  end

  # GET /strore_groups/1
  # GET /strore_groups/1.xml
  def show
    @store_group = StoreGroup.find(params[:id])
    @stores_in_groups = @store_group.stores_in_groups
    @stores = Store.all

    @stores.delete_if {|store| @stores_in_groups.map{|x|x.id}.include?(store.id)}

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @store_group }
    end
  end

  # GET /strore_groups/new
  # GET /strore_groups/new.xml
  def new
    @store_group = StoreGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @store_group }
    end
  end

  # GET /strore_groups/1/edit
  def edit
    @store_group = StoreGroup.find(params[:id])
  end

  # POST /strore_groups
  # POST /strore_groups.xml
  def create
    @store_group = StoreGroup.new(params[:store_group])

    respond_to do |format|
      if @store_group.save
        flash[:notice] = 'StoreGroup was successfully created.'
        format.html { redirect_to(@store_group) }
        format.xml  { render :xml => @store_group, :status => :created, :location => @store_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @store_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /strore_groups/1
  # PUT /strore_groups/1.xml
  def update
    @store_group = StoreGroup.find(params[:id])

    respond_to do |format|
      if @store_group.update_attributes(params[:store_group])
        flash[:notice] = 'StoreGroup was successfully updated.'
        format.html { redirect_to(@store_group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @store_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /strore_groups/1
  # DELETE /strore_groups/1.xml
  def destroy
    @store_group = StoreGroup.find(params[:id])
    @store_group.destroy

    respond_to do |format|
      format.html { redirect_to(store_groups_url) }
      format.xml  { head :ok }
    end
  end
end
