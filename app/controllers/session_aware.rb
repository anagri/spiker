module SessionAware
  def self.included(klass)
    klass.class_eval <<-EOV
      hide_action :current_user
    EOV
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = Session.find
  end
end