class OfficesController < ApplicationController
  filter_resource_access

  def index
    @parent_office = current_user.office
  end

  def new
    @parent_office = current_user.office
  end

  def show; end

  def create
    @parent_office = current_user.office
    if @office.save
      flash_success_msg
      redirect_to @office
    else
      flash_error_msg
      render :action => 'new', :status => :unprocessable_entity
    end
  end
end