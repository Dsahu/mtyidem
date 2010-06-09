# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  require 'lib/ruby_and_rails_helpers.rb'

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  layout 'application'

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  protected
  
  def admin_required
  	redirect_to :controller => 'home' unless current_user && current_user.is_idem_admin == true
  end
  
end
