class DashboardController < ApplicationController
  filter_access_to :all

  def index;
  end

  def offices
    @parent_office = current_user.office
    @office_types = OfficeType.all
    @office_type = OfficeType.new
    @additional_attributes = AdditionalAttribute.find(:all, :conditions => {:resource_type => Office.name})
    render :layout => 'offices_dashboard'
  end

  def users
    @users = User.all
    @additional_attributes = AdditionalAttribute.find(:all, :conditions => {:resource_type => User.name})
    render :layout => 'users_dashboard'
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