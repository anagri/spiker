class ClientTypesController < ApplicationController
  filter_resource_access

  def index
    @client_types = ClientType.roots
  end

  def new; end

  def show; end

  def create
    if @client_type.save
      flash[:msg] = success_msg
      redirect_to @client_type
    else
      flash_error_msg
      render :action => 'new', :status => :unprocessable_entity
    end
  end
end