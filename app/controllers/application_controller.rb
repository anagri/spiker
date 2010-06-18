# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include SessionAware
  helper :all
  protect_from_forgery

  filter_parameter_logging :password, :password_confirmation

  helper_method :current_user

  before_filter {|controller| Authorization.current_user = controller.current_user}

  def permission_denied
    flash[:error] = msg_key('unauthorized')
    render :action => 'unauthorized', :status => 401
  end

  def msg_key(key)
    "#{params[:controller]}.#{params[:action]}.#{key}"
  end

  def error_msg
    msg_key('error')
  end

  def success_msg
    msg_key('success')
  end
end
