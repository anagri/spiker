class DashboardController < ApplicationController
  filter_access_to :all

  def index; end

  def offices
    @office = Office.new
    @parent_office = current_user.office
    @office_types = OfficeType.all
    @office_type = OfficeType.new
    render :layout => 'offices_dashboard'
  end

  def navigate
    redirect_to (params[:navigate] && params[:navigate][:to]) || dashboard_path
  end

  protected
  def permission_denied
    flash[:error] = 'You cannot access dashboard page without logging in'
    redirect_to root_url
  end
end