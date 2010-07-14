class AdditionalAttributesController < ApplicationController
  filter_resource_access
  before_filter :new_additional_attribute_from_params, :only => :index

  def index
    @additional_attributes = AdditionalAttribute.all
  end

  def show
  end

  def new;
  end

  def create
    if @additional_attribute.save
      flash[:info] = success_msg
      redirect_to :action => :show, :id => @additional_attribute.id
    else
      flash[:error] = error_msg
      render :action => 'new', :status => :unprocessable_entity
    end
  end

  protected
  def new_additional_attribute_from_params
    if params[:additional_attribute] && AdditionalAttribute.valid_field_type?(params[:additional_attribute][:type])
      field_class = params[:additional_attribute][:type].constantize
      @additional_attribute = field_class.new(params[:additional_attribute])
    else
      @additional_attribute = AdditionalAttribute.new(params[:additional_attribute])
    end
  end

  def load_additional_attribute
    @additional_attribute = AdditionalAttribute.find(params[:id])
  end
end