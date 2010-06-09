class StoresInGroupsController < ApplicationController

  layout 'application'

  before_filter :admin_required


  # GET /stores_in_groups
  # GET /stores_in_groups.xml
  def index
    @stores_in_groups = StoresInGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stores_in_groups }
    end
  end

  # GET /stores_in_groups/1
  # GET /stores_in_groups/1.xml
  def show
    @stores_in_group = StoresInGroup.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stores_in_group }
    end
  end

  # GET /stores_in_groups/new
  # GET /stores_in_groups/new.xml
  def new
    @stores_in_group = StoresInGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @stores_in_group }
    end
  end

  # GET /stores_in_groups/1/edit
  def edit
    @stores_in_group = StoresInGroup.find(params[:id])
  end

  # POST /stores_in_groups
  # POST /stores_in_groups.xml
  def create
    @stores_in_group = StoresInGroup.new(params[:stores_in_group])

    respond_to do |format|
      if @stores_in_group.save
        flash[:notice] = 'StoresInGroup was successfully created.'
        format.html { redirect_to(@stores_in_group) }
        format.xml  { render :xml => @stores_in_group, :status => :created, :location => @stores_in_group }
        format.js {
          render :update do |pg|
            html_text = "<tr><td>#{@stores_in_group.store.name}</td><td><a onClick='remove_store_from_group(#{@stores_in_group.id})'>Quitar</a></td></tr>"
            pg.insert_html :bottom, "added_stores_table", html_text
          end
        }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @stores_in_group.errors, :status => :unprocessable_entity }
        format.js {
          render :update do |pg|
            pg.call "alert", "hey"
          end
        }
      end
    end
  end

  # PUT /stores_in_groups/1
  # PUT /stores_in_groups/1.xml
  def update
    @stores_in_group = StoresInGroup.find(params[:id])

    respond_to do |format|
      if @stores_in_group.update_attributes(params[:stores_in_group])
        flash[:notice] = 'StoresInGroup was successfully updated.'
        format.html { redirect_to(@stores_in_group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stores_in_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stores_in_groups/1
  # DELETE /stores_in_groups/1.xml
  def destroy
    @stores_in_group = StoresInGroup.find(params[:id])
    @stores_in_group.destroy

    respond_to do |format|
      format.html { redirect_to(stores_in_groups_url) }
      format.xml  { head :ok }
    end
  end
end
