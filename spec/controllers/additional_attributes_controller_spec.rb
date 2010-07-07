require File.dirname(__FILE__) + '/spec_helper'

describe AdditionalAttributesController do
  describe 'authorization' do
    before(:each) do
      @resource_id = Factory.without_access_control_do_create(:additional_attribute).id
      @create_params = {:additional_attribute => {:name => 'location', :field_type => 'string', :resource_type => 'User', :length => '30'}}
    end

    it_should_behave_like 'authenticated user staff viewed and admin managed controller'
  end

  describe 'create' do
    before(:each) do
      @model_class = AdditionalAttribute
    end

    it_should_behave_like 'create with xhr support'
  end
end