class DashboardController < ApplicationController
  filter_access_to :all
  before_filter :convert_params_to_hash

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

  def convert_params_to_hash
    if request.method == :get
      url_params = params.reject { |key, value| key == 'controller' || key == 'action' }
      redirect_to url_for(:action => params[:action]) << "#" << url_params.map { |k, v| "#{k}=#{v}" }.join('&') unless url_params.blank?
    end
  end
end