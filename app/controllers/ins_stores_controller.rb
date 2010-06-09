class InsStoresController < ApplicationController

  layout 'application'

  before_filter :admin_required

  # GET /ins_stores
  # GET /ins_stores.xml
  def index
    @ins_stores = InsStore.all
    @runs = Run.find(:all, :select => "id, name")
    @store_groups = StoreGroup.all
    @stores = Store.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ins_stores }
    end
  end

  def add_store_group

    @ins_stores = []
    store_group = StoreGroup.find(params[:store_group_id])
    stores = store_group.stores
    stores.each do |store|
      ins_store = InsStore.new

      ins_store.run_id = params[:run_id]
      ins_store.store_id = store.id
      ins_store.name = store.name
      ins_store.description = store.description

      @ins_stores << ins_store
    end

    @ins_stores.each {|is| is.save }

    respond_to do |format|
      format.js do
        html_text = ""
        @ins_stores.each do |is|
          unless is.new_record?
            html_text << "<tr><td>#{is.name}</td><td>#{is.description}</td><td><a onClick='remove_ins_store(<%=is.id%>)'>Quitar</a></td></tr>"
          end
        end
        render :update do |pg|
          pg.insert_html :bottom, "ins_stores_table", html_text
        end
      end
    end

  end

  def add_store
    @ins_store = InsStore.new
    @ins_store.run_id = params[:run_id]
    @ins_store.store_id = params[:store_id]
    store = Store.find(params[:store_id])
    @ins_store.name = store.name
    @ins_store.description = store.description

    if @ins_store.save
      respond_to do |format|
        format.js {
          render :update do |pg|
            pg.insert_html :bottom, "ins_stores_table", "<tr><td>#{@ins_store.name}</td><td>#{@ins_store.description}</td><td><a onClick='remove_ins_store(<%=is.id%>)'>Quitar</a></td></tr>"
          end
        }
      end
    else
      render :nothing => true
    end
  end

  def search
    @ins_stores = InsStore.find(:all, :conditions => {:run_id => params[:run_id]}) if params[:run_id]
    @ins_stores ||= []

    respond_to do |format|
      format.js {render :action => "search", :layout => false }
    end

  end

  # GET /ins_stores/1
  # GET /ins_stores/1.xml
  def show
    @ins_store = InsStore.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ins_store }
    end
  end

  # GET /ins_stores/new
  # GET /ins_stores/new.xml
  def new
    @ins_store = InsStore.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ins_store }
    end
  end

  # GET /ins_stores/1/edit
  def edit
    @ins_store = InsStore.find(params[:id])
  end

  # POST /ins_stores
  # POST /ins_stores.xml
  def create
    @ins_store = InsStore.new(params[:ins_store])

    respond_to do |format|
      if @ins_store.save
        flash[:notice] = 'InsStore was successfully created.'
        format.html { redirect_to(@ins_store) }
        format.xml  { render :xml => @ins_store, :status => :created, :location => @ins_store }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ins_store.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ins_stores/1
  # PUT /ins_stores/1.xml
  def update
    @ins_store = InsStore.find(params[:id])

    respond_to do |format|
      if @ins_store.update_attributes(params[:ins_store])
        flash[:notice] = 'InsStore was successfully updated.'
        format.html { redirect_to(@ins_store) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ins_store.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ins_stores/1
  # DELETE /ins_stores/1.xml
  def destroy
    @ins_store = InsStore.find(params[:id])
    @ins_store.destroy

    respond_to do |format|
      format.html { redirect_to(ins_stores_url) }
      format.xml  { head :ok }
      format.js   { render :text => "ok"}
    end
  end
end
