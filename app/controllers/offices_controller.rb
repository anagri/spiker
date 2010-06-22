class OfficesController < ApplicationController
  filter_resource_access

  def index; end

  def new
    @user = current_user
  end

  def show; end

  def create
    if @office.save
      flash[:info] = success_msg
      redirect_to @office
    else
      flash[:error] = error_msg
      render :action => 'new'
    end
  end
end