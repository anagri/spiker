class DashboardController < ApplicationController
  filter_access_to :all

  def index; end

  def navigate
    redirect_to params[:navigate][:to]
  end

  protected
  def permission_denied
    flash[:error] = 'You cannot access dashboard page without logging in'
    redirect_to root_url
  end
end