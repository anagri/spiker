require File.dirname(__FILE__) + '/spec_helper'

describe UsersController do
  before(:each) do
    activate_authlogic
  end

  describe 'authorization' do
    describe 'for user himself' do
      before(:each) do
        @user = staff
        @allowed_actions = modify_actions
        @update_params = {:id => @user.id, :user => {}}
        @resource_id = @user.id
        User.any_instance.stubs(:update_attributes).returns(true)
        Session.stubs(:create)
      end

      it_should_behave_like 'authorized controller'
    end

    describe 'for other users' do
      before(:each) do
        @logged_in = staff
        @other_user = staff(true)
        @allowed_actions = none_actions
        @update_params = {:id => @other_user.id, :user => {}}
        @resource_id = @other_user.id
      end

      it_should_behave_like 'authorized controller'
    end

    describe 'for admin' do
      before(:each) do
        @user = admin
        @allowed_actions = manage_actions + Set['edit_profile']
        @update_params = {:id => @user.id, :user => {}}
        @office_type = Factory._create(:office_type)
        @create_params = {:user => {:username => 'testuser', :password => 'testpass', :email => 'test@user.com', :password_confirmation => 'testpass', :office => Factory.build(:office, :office_type => @office_type), :role => 'staff'}}
        @resource_id = @user.id
        User.stubs(:all).returns([])
        User.any_instance.stubs(:update_attributes).returns(true)
        Session.stubs(:create)
      end

      it_should_behave_like 'authorized controller'
    end

    describe 'for guest' do
      before(:each) do
        @other_user = staff
        @user = guest
        @allowed_actions = none_actions
        @resource_id = @other_user.id
      end

      it_should_behave_like 'authorized controller'
    end
  end
end
