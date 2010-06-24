class OfficeTypesController < ApplicationController
  filter_resource_access

  def index; end

  def edit; end

  def update; end

  protected
  def new_office_type_for_collection

  end

  def load_office_type

  end

  hide_action :new_office_type_for_collection, :load_office_type
end