class UserResultAssignmentsController < ApplicationController

  before_filter :admin_required, :except => [:assign]
  before_filter :login_required

  # GET /user_result_assignments
  # GET /user_result_assignments.xml
  def index
    @user_result_assignments = UserResultAssignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_result_assignments }
    end
  end

  def assign

    results = Result.find(:all, :conditions => {:id => params[:id]})

    if results.length > 0

      if Result.find(:all, :conditions => {:user_id => current_user.id, :run_id => results.first.run_id}).length == 0
        if UserResultAssignment.find(:all, :conditions => {:user_id => current_user.id, :run_id => results.first.run_id}).length == 0
          unless UserResultAssignment.find(:all, :conditions => {:user_id => current_user.id, :result_id => params[:id]}).length > 0
            @user_result_assignment = UserResultAssignment.new(:user_id => current_user.id)
            @user_result_assignment.result_id = params[:id]
            @user_result_assignment.run_id = results.first.run_id
            @user_result_assignment.save

            respond_to do |format|
              format.html {render :nothing => true}
              format.js {
                render :update do |pg|

                  pg.call(:my_highlight, ".resitem_#{params[:id]}")

                end
              }
            end

          else
            respond_to do |format|
              format.html {render :nothing => true}
              format.js {
                 render :update do |pg|
                    pg.call("alert", "Este resultado ya se assignó a ti.")
                 end
              }
            end
          end
        else
          respond_to do |format|
            format.html {render :nothing => true}
            format.js {
               render :update do |pg|
                  pg.call("alert", "Ya se assignó un resultado de esa carrera a ti.")
               end
            }
          end
        end
      else
        respond_to do |format|
          format.html {render :nothing => true}
          format.js {
             render :update do |pg|
                pg.call("alert", "Ya tines un resultado de esa carrera.")
             end
          }
        end
      end
    else
      respond_to do |format|
        format.html {render :nothing => true}
        format.js {
           render :update do |pg|
              pg.call("alert", "Resultado no existe.")
           end
        }
      end
    end
  end


  # GET /user_result_assignments/1
  # GET /user_result_assignments/1.xml
  def show
    @user_result_assignment = UserResultAssignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_result_assignment }
    end
  end

  # GET /user_result_assignments/new
  # GET /user_result_assignments/new.xml
  def new
    @user_result_assignment = UserResultAssignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_result_assignment }
    end
  end

  # GET /user_result_assignments/1/edit
  def edit
    @user_result_assignment = UserResultAssignment.find(params[:id])
  end

  # POST /user_result_assignments
  # POST /user_result_assignments.xml
  def create
    @user_result_assignment = UserResultAssignment.new(params[:user_result_assignment])

    respond_to do |format|
      if @user_result_assignment.save
        flash[:notice] = 'UserResultAssignment was successfully created.'
        format.html { redirect_to(@user_result_assignment) }
        format.xml  { render :xml => @user_result_assignment, :status => :created, :location => @user_result_assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_result_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_result_assignments/1
  # PUT /user_result_assignments/1.xml
  def update
    @user_result_assignment = UserResultAssignment.find(params[:id])

    respond_to do |format|
      if @user_result_assignment.update_attributes(params[:user_result_assignment])
        flash[:notice] = 'UserResultAssignment was successfully updated.'
        format.html { redirect_to(@user_result_assignment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_result_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_result_assignments/1
  # DELETE /user_result_assignments/1.xml
  def destroy
    @user_result_assignment = UserResultAssignment.find(params[:id])
    @user_result_assignment.destroy

    respond_to do |format|
      format.html { redirect_to(user_result_assignments_url) }
      format.xml  { head :ok }
    end
  end
end
