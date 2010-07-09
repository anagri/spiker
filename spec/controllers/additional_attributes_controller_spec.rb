require File.dirname(__FILE__) + '/spec_helper'

describe AdditionalAttributesController do
  describe 'authorization' do
    before(:each) do
      @resource_id = Factory.without_access_control_do_create(:string_attribute).id
      @create_params = {:additional_attribute => {:name => 'location', :type => 'StringAttribute', :resource_type => 'User', :length => '30'}}
    end

    it_should_behave_like 'authenticated user staff viewed and admin managed controller'
  end

  describe 'create' do
    before(:each) do
      @model_class = StringAttribute
      @redirect_url = additional_attribute_url(1)
      @create_params = {:additional_attribute => {:type => 'StringAttribute'}}
    end

    it_should_behave_like 'create with xhr support'
  end
end