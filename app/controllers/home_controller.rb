class HomeController < ApplicationController
  filter_access_to :all

  def index; end

  protected
  def permission_denied
    redirect_to dashboard_url
  end
end
