# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include SessionAware
  helper :all
  protect_from_forgery

  filter_parameter_logging :password, :password_confirmation

  helper_method :current_user

  before_filter {|controller| Authorization.current_user = controller.current_user}

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

  def error_msg
    msg_key('error')
  end

  def success_msg
    msg_key('success')
  end

  def support_xhr
    @before = instance_variable_names
  end

  # render xhr request with partials
  def render(options = nil, extra_options = {}, &block)
    unless instance_variable_defined?("@before".to_sym)
      return super
    end

    @before << "@before"
    set_vars = instance_variable_names - @before

    locals = HashWithIndifferentAccess.new
    set_vars.each do |var|
      locals[var.gsub(/@/, '').to_sym] = instance_variable_get(var.to_sym)
    end

    default_options = {:action => params[:action], :status => 200}.merge(options || {})
    if request.xhr?
      if interpret_status(default_options[:status]) =~ /^(201|301|302).*$/ # rendering headless requests
        super
      else
        super :partial => default_options[:action], :status => default_options[:status], :locals => locals
      end
    else
      super
    end
  end

  def redirect_to(options = {}, response_status = {})
    unless instance_variable_defined?("@before".to_sym)
      return super
    end
    if request.xhr?
      head :created, :location => url_for(options)
    else
      super
    end
  end
end
