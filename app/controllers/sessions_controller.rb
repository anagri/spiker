class SessionsController < ApplicationController
  before_filter :new_session_from_params, :only => :new
  before_filter :load_session, :only => :destroy
  filter_resource_access
  layout 'full_page'

  def new
    @session = Session.new
  end

  def create
    if @session.without_access_control_do_save
      flash_success_msg
      respond_to do |format|
        format.html { redirect_to dashboard_url }
        format.xml { head :status => :created, :location => dashboard_path }
      end
    else
      flash_error_msg
      render :action => 'new'
    end
  end

  def destroy
    @session.destroy
    reset_session
    flash_success_msg
    redirect_to root_url
  end

  protected
  def permission_denied
    redirect_to (params[:action].to_sym == :destroy ? root_url : dashboard_url)
  end

  def new_session_from_params
    @session = Session.new(params[:session])
  end

  def load_session
    @session = Session.find
  end
end
