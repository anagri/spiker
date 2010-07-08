class OfficeTypesController < ApplicationController
  before_filter :new_office_type_for_collection, :only => [:index, :create]
  before_filter :new_office_type_from_params, :only => [:index]

  filter_resource_access

  layout Proc.new {|controller| controller.request.xhr? ? nil : 'application'}

  def index; end

  def create
    if @office_type.save
      flash[:info] = success_msg
      redirect_to office_types_url
    else
      flash[:error] = error_msg
      render :action => 'index', :status => :unprocessable_entity
    end
  end

  protected
  def new_office_type_for_collection
    @office_types = OfficeType.all
  end

  def new_office_type_from_params
    @office_type = OfficeType.new((params[:office_type] || {}).merge!(:parent_id => OfficeType.leaf.id))
  end
end