# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include SimpleCaptcha::ControllerHelpers
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :card_number, :card_verification
  
protected
  
  def authorize
    if logged_in?
      unless current_user.admin?
        flash[:error] = "Nosiree!"
        redirect_to root_path
        false
      end
    end
  end
end
