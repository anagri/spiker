require File.dirname(__FILE__) + '/spec_helper'

describe OfficesController do
  before(:each) do
    @resource_id = Factory.without_access_control_do_create(:office).id
    @create_params = {:office => {:name => 'office name', :parent => Office.root, :office_type => Factory.without_access_control_do_create(:office_type)}}
  end

  describe 'authorization' do
    describe 'for admin' do
      before(:each) do
        @user = admin
      end

      it_should_behave_like 'authorized controller'
    end

    describe 'for staff' do
      before(:each) do
        @user = staff
        @allowed_actions = view_actions
      end

      it_should_behave_like 'authorized controller'
    end

    describe 'for guest' do
      before(:each) do
        @user = guest
        @allowed_actions = none_actions
      end

      it_should_behave_like 'authorized controller'
    end
  end
end
