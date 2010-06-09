class InvitationInputsController < ApplicationController
  # GET /invitation_inputs
  # GET /invitation_inputs.xml
  def index
    @invitation_inputs = InvitationInput.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invitation_inputs }
    end
  end

  # GET /invitation_inputs/1
  # GET /invitation_inputs/1.xml
  def show
    @invitation_input = InvitationInput.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invitation_input }
    end
  end

  # GET /invitation_inputs/new
  # GET /invitation_inputs/new.xml
  def new
    @invitation_input = InvitationInput.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @invitation_input }
    end
  end

  # GET /invitation_inputs/1/edit
  def edit
    @invitation_input = InvitationInput.find(params[:id])
  end

  # POST /invitation_inputs
  # POST /invitation_inputs.xml
  def create
    @invitation_input = InvitationInput.new(params[:invitation_input])

    respond_to do |format|
      if @invitation_input.save
        flash[:notice] = 'InvitationInput was successfully created.'
        format.html { redirect_to(@invitation_input) }
        format.xml  { render :xml => @invitation_input, :status => :created, :location => @invitation_input }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @invitation_input.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /invitation_inputs/1
  # PUT /invitation_inputs/1.xml
  def update
    @invitation_input = InvitationInput.find(params[:id])

    respond_to do |format|
      if @invitation_input.update_attributes(params[:invitation_input])
        flash[:notice] = 'InvitationInput was successfully updated.'
        format.html { redirect_to(@invitation_input) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invitation_input.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /invitation_inputs/1
  # DELETE /invitation_inputs/1.xml
  def destroy
    @invitation_input = InvitationInput.find(params[:id])
    @invitation_input.destroy

    respond_to do |format|
      format.html { redirect_to(invitation_inputs_url) }
      format.xml  { head :ok }
    end
  end
end
