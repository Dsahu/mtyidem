class UsersController < ApplicationController
  
  before_filter :login_required, :except => [:create, :activate, :new, :pwdforgotten, :change_forgotten_password]
  
  # render new.rhtml
  def new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      render :action => 'new'
    end
  end

  def activate
    self.current_user = params[:activation_code].blank? ? false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate
      flash[:notice] = "Signup complete!"
    end
    redirect_back_or_default('/')
  end
  
  def upload_profile_pic
    # JUST WITH AJAX
    if current_user.id == params[:id].to_i
      Filesupload.user_profile_pic(params[:upload], current_user)
    end
    redirect_to("/profile")
  end
  
  def edit
    if current_user.id == params[:id].to_i
      render :action => 'edit'
    else
      redirect_to("/")
    end
  end
  
  def update
    if current_user.id == params[:id].to_i
      current_user.update_attributes(params[:user])
      redirect_to(current_user.profile_path)
    else
      redirect_to("/")
    end
  end
  
  def editpwd
    if current_user.id == params[:id].to_i
      render :action => 'editpwd'
    else
      redirect_to("/")
    end
  end

  def chpwd
    
    # params:
    # pwd => {:old => "aaa", :new => "xxx", :new_confirm => "xxx"}
    
    if current_user.id == params[:id].to_i
      if params[:pwd][:new] == params[:pwd][:new_confirm]
        if current_user.authenticated?(params[:pwd][:old])
          current_user.change_password!(params[:pwd][:new])
          redirect_to(current_user.profile_path)
        else
          flash[:error] = "<p>Tu contraseña no es correcto</p>"
          render :action => 'editpwd'
        end
      else
        flash[:error] = "<p>La nueva contraseña y su confirmación no concuerdan</p>"
        render :action => 'editpwd'
      end
    else
      redirect_to("/")
    end
  end
  
  def pwdforgotten
  end

  def change_forgotten_password
    # params[:id] is 0
    @user = User.find_by_email(params[:email])
    @newpwd = User.generate_random_password(8)
    
    if @user
      @user.change_password!(@newpwd)
      EmailNotification.deliver_password_change(@user.email, @newpwd)
      
    else
      redirect_to("/")
    end
    
  end

end
