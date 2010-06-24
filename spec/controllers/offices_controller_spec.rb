require File.dirname(__FILE__) + '/spec_helper'

describe OfficesController do
  describe 'authorization' do
    before(:each) do
      @controller_class = OfficesController
      @resource_id = Factory.without_access_control_do_create(:office).id
      @create_params = {:office => {:name => 'office name', :parent => Office.root, :office_type => Factory.without_access_control_do_create(:office_type)}}
    end

    it_should_behave_like "authorized controller"
  end
end
