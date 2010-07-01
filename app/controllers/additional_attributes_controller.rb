class AdditionalAttributesController < ApplicationController
  filter_resource_access

  def index
    @additional_attributes = AdditionalAttribute.all
  end

  def show;
  end

  def new;
  end

  def create
    pp params[:additional_attribute]
    if @additional_attribute.save
      flash[:info] = success_msg
      redirect_to @additional_attribute
    else
      flash[:error] = error_msg
      render :action => 'new'
    end
  rescue Exception => e
    pp e.message
    pp e.backtrace

    flash[:error] = 'Try again !!!'
    render :action => 'new'
  end
end