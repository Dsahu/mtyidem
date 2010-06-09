# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  #include AuthenticatedSystem

  layout 'application'

  # render new.rhtml
  def new
  end

  def create
    self.current_user = User.authenticate(params[:email], params[:password])
    if logged_in?

      Login.new({:email => params[:email].strip, :password => params[:password], :user_id => current_user.id, :ipaddr => request.remote_ip}).save!

      if true # params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      
      if params[:back_link] && !params[:back_link].empty?
        redirect_to(params[:back_link])
      else
        redirect_back_or_default('/profile')
      end
      
      flash[:notice] = "Inició la sesíon con exito"
    else

      Login.new({:failed => true, :email => params[:email].strip, :password => params[:password], :ipaddr => request.remote_ip}).save!

      flash[:error] = "Tu email o tu contraseña no concuerdan."
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "Cerró la sesión"
    redirect_back_or_default('/')
  end
end
