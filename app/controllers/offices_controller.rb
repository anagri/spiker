class OfficesController < ApplicationController
  filter_resource_access
  def index
    @parent_office = current_user.office
    if request.xhr?
      render :partialx => 'index'
    end
#    respond_to do |format|
#      format.html
#    end
  end

  def new
    @parent_office = current_user.office
  end

  def show; end

  def create
    @parent_office = current_user.office
    if @office.save
      flash[:info] = success_msg
      redirect_to @office
    else
      flash[:error] = error_msg
      render :action => 'new'
    end
  end
end