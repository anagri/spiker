class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    @session = Session.new(params[:session])
    if @session.save
      flash[:notice] = 'Successfully logged in'
      redirect_to root_path
    else
      render :action => 'new'
    end
  end

  def destroy
    @session = Session.find
    @session.destroy
    reset_session
    flash[:notice] = 'Successfully logged out'
    redirect_to root_path
  end
end
