class FriendrelationsController < ApplicationController
  # GET /friendrelations
  # GET /friendrelations.xml
  def index
    @friendrelations = Friendrelation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @friendrelations }
    end
  end

  # GET /friendrelations/1
  # GET /friendrelations/1.xml
  def show
    @friendrelation = Friendrelation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @friendrelation }
    end
  end

  # GET /friendrelations/new
  # GET /friendrelations/new.xml
  def new
    @friendrelation = Friendrelation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @friendrelation }
    end
  end

  # GET /friendrelations/1/edit
  def edit
    @friendrelation = Friendrelation.find(params[:id])
  end

  # POST /friendrelations
  # POST /friendrelations.xml
  def create
    @friendrelation = Friendrelation.new(params[:friendrelation])

    respond_to do |format|
      if @friendrelation.save
        flash[:notice] = 'Friendrelation was successfully created.'
        format.html { redirect_to(@friendrelation) }
        format.xml  { render :xml => @friendrelation, :status => :created, :location => @friendrelation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @friendrelation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /friendrelations/1
  # PUT /friendrelations/1.xml
  def update
    @friendrelation = Friendrelation.find(params[:id])

    respond_to do |format|
      if @friendrelation.update_attributes(params[:friendrelation])
        flash[:notice] = 'Friendrelation was successfully updated.'
        format.html { redirect_to(@friendrelation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @friendrelation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /friendrelations/1
  # DELETE /friendrelations/1.xml
  def destroy
    @friendrelation = Friendrelation.find(params[:id])
    @friendrelation.destroy

    respond_to do |format|
      format.html { redirect_to(friendrelations_url) }
      format.xml  { head :ok }
    end
  end
end
