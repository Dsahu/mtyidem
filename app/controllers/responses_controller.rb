class ResponsesController < ApplicationController
  # GET /responses
  # GET /responses.xml
  def index
    @responses = Response.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @responses }
    end
  end

  # GET /responses/1
  # GET /responses/1.xml
  def show
    @response = Response.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @response }
    end
  end

  # GET /responses/new
  # GET /responses/new.xml
  def new
    @response = Response.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @response }
    end
  end

  # GET /responses/1/edit
  def edit
    @response = Response.find(params[:id])
  end

  # POST /responses
  # POST /responses.xml
  def create
    @response = Response.new(params[:response])
    @response.by_user_id = current_user.id
    
    respond_to do |format|
      if @response.save

        format.html { redirect_to(@response) }
        format.xml  { render :xml => @response, :status => :created, :location => @response }
        format.js   {
          render :update do |pg|
            pg.insert_html :bottom, "wallevent_#{@response.wallevent_id}_responses_table", :partial => 'one_response', :locals => {:response => @response}
            pg.visual_effect :highlight, "response_#{@response.id}", :duration => 2
            pg.replace_html "wallevent_#{@response.wallevent_id}_responsecount", @response.wallevent.responses.length.to_s
          end
        }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @response.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /responses/1
  # PUT /responses/1.xml
  def update
    @response = Response.find(params[:id])

    respond_to do |format|
      if @response.update_attributes(params[:response])
        format.html { redirect_to(@response) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @response.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.xml
  def destroy
    @response = Response.find(params[:id])
    @response.destroy

    respond_to do |format|
      format.html { redirect_to(responses_url) }
      format.xml  { head :ok }
    end
  end
end
