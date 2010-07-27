# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include SessionAware
  helper :all
  protect_from_forgery

  filter_parameter_logging :password, :password_confirmation

  helper_method :current_user

  before_filter {|controller| Authorization.current_user = controller.current_user}
  before_filter :support_xhr, :only => [:create, :update]

  layout Proc.new {|controller| controller.request.xhr? ? nil : 'application'}

  protected

  def permission_denied
    logger.warn "Permission denied: No matching filter access " +
            "rule found for #{self.class.controller_name}.#{action_name}"
    flash[:error] = msg_key('unauthorized')
    render :action => 'unauthorized', :status => 401
  end

  def msg_key(key)
    "#{params[:controller]}.#{params[:action]}.#{key}"
  end

  def flash_error_msg(keep = false)
    (keep ? flash : flash.now)[:error] = error_msg
  end

  def error_msg
    msg_key('error')
  end

  def flash_success_msg
    flash[:notice] = success_msg
  end

  def success_msg
    msg_key('success')
  end

  def support_xhr
    @support_xhr = true
  end

  def redirect_to(options = {}, response_status = {})
    unless instance_variable_defined?(:@support_xhr)
      return super
    end
    if request.xhr?
      head :created, :location => url_for(options)
    else
      super
    end
  end
end
