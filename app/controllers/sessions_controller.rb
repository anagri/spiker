class SessionsController < ApplicationController
  before_filter :new_session_from_params, :only => :new
  before_filter :load_session, :only => :destroy
  filter_resource_access

  def new
    @session = Session.new
  end

  def create
    if @session.save
      flash[:notice] = 'Successfully logged in'
      respond_to do |format|
        format.html { redirect_to root_path }
        format.xml { head :status => :created, :location => root_path }
      end
    else
      render :action => 'new'
    end
  end

  def destroy
    @session.destroy
    reset_session
    flash[:notice] = 'Successfully logged out'
    redirect_to root_path
  end

  protected
  def new_session_from_params
    @session = Session.new(params[:session])
  end

  def load_session
    @session = Session.find
  end
end
