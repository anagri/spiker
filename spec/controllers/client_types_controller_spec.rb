require File.dirname(__FILE__) + '/spec_helper'

describe ClientTypesController do
  describe 'authorization' do
    before(:each) do
      @create_params = {:client_type => {:name => 'test client type'}}
      @resource_id = Factory._create(:client_type).id
    end

    it_should_behave_like 'authenticated user staff viewed and admin managed controller'
  end

  describe 'create' do
    before(:each) do
      @model_class = ClientType
    end

    it_should_behave_like 'create with xhr support'
  end
end