class OfficesController < ApplicationController
  filter_resource_access
  before_filter :load_user, :only => [:index, :new]

  def index; end

  def new; end

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