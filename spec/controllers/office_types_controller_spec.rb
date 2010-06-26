require File.dirname(__FILE__) + '/spec_helper'

describe OfficeTypesController do
  describe 'authorization' do
    before(:each) do
      @create_params = {:office_type => {:name => 'test office type'}}
      @resource_id = Factory.without_access_control_do_create(:office_type).id
    end

    it_should_behave_like 'authenticated user staff viewed and admin managed controller'
  end
end