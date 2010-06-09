class InscriptionsController < ApplicationController
  
  before_filter :admin_required, :except => [:index, :new, :create]
  
  layout 'application'
  
  # GET /inscriptions
  # GET /inscriptions.xml
  def index
    @inscriptions = Inscription.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @inscriptions }
    end
  end

  # GET /inscriptions/1
  # GET /inscriptions/1.xml
  def show
    @inscription = Inscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @inscription }
    end
  end

  # GET /inscriptions/new
  # GET /inscriptions/new.xml
  def new
    
    if current_user
    
      @run = Run.find(params[:run_id]) if params[:run_id]
      @inscription = Inscription.new
      @inscription.run_id = @run.id if @run
      @runevents = @run.runevents if @run
      @payconds = @run.payconds if @run


      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @inscription }
      end

    
    else
      @run = Run.find(params[:run_id]) if params[:run_id]
      if @run && params[:forced] == "1"
        @inscription = Inscription.new
        @inscription.run_id = @run.id if @run
        @runevents = @run.runevents if @run
        @payconds = @run.payconds if @run
        render :action => 'inscription_without_user'
      elsif @run
        render :action => 'inscription_mode_select'
      else
        render :action => 'new'
      end
    end
    
  end

  # GET /inscriptions/1/edit
  def edit
    @inscription = Inscription.find(params[:id])
  end

  # POST /inscriptions
  # POST /inscriptions.xml
  def create
    @inscription = Inscription.new(params[:inscription])
    current_user ? age = current_user.age : age = params[:inscription][:age].to_i

    respond_to do |format|
      if @inscription.save
        #flash[:notice] = 'Inscription was successfully created.'
        format.html { redirect_to(@inscription.paypal_url(age, payment_notifications_url)) }
        format.xml  { render :xml => @inscription, :status => :created, :location => @inscription }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @inscription.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /inscriptions/1
  # PUT /inscriptions/1.xml
  def update
    @inscription = Inscription.find(params[:id])

    respond_to do |format|
      if @inscription.update_attributes(params[:inscription])
        #flash[:notice] = 'Inscription was successfully updated.'
        format.html { redirect_to(@inscription) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inscription.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /inscriptions/1
  # DELETE /inscriptions/1.xml
  def destroy
    @inscription = Inscription.find(params[:id])
    @inscription.destroy

    respond_to do |format|
      format.html { redirect_to(inscriptions_url) }
      format.xml  { head :ok }
    end
  end
end
