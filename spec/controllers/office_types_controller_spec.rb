require File.dirname(__FILE__) + '/spec_helper'

describe OfficeTypesController do
  describe 'authorization' do
    before(:each) do
      @controller_class = OfficeTypesController
      @resource_id = Factory.without_access_control_do_create(:office_type).id
      @user = admin
      @create_params = {:office_type => {:name => 'office type 1'}}
    end

    it_should_behave_like 'authorized controller'
  end
end