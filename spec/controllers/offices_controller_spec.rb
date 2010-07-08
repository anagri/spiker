require File.dirname(__FILE__) + '/spec_helper'

describe OfficesController do
  describe 'authorization' do
    before(:each) do
      @office_type = Factory._create(:office_type)
      @resource_id = Factory._create(:office, :office_type => @office_type).id
      @create_params = {:office => {:name => 'office name', :parent_id => Office.root.id, :office_type_id => Factory.without_access_control_do_create(:office_type).id}}
    end

    it_should_behave_like 'authenticated user staff viewed and admin managed controller'
  end
end
