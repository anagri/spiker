class ClientTypesController < ApplicationController
  filter_resource_access

  def index
    @client_types = ClientType.roots
  end

  def create
    if @client_type.save
      flash[:msg] = success_msg
      redirect_to client_types_url
    else
      flash[:error] = error_msg
      render :action => 'index'
    end
  end
end