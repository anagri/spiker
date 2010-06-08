require File.dirname(__FILE__) + '/spec_helper'

describe UsersController do
  before(:each) do
    activate_authlogic
  end

  describe 'new' do
    it 'should define new user' do
      get :new
      response.should be_success
      assigns[:user].should_not be_nil
    end
  end

  describe 'create' do
    it 'should create new user' do
      get :create, :user => {:username => 'dummyuser', :email => 'dummyemail@dmail.com', :password => 'dummypassword', :password_confirmation => 'dummypassword'}
      created_user = User.find_by_username('dummyuser')
      response.should have_created_resource(created_user, user_path(created_user))
    end

    it 'should return error if user not created' do
      #bad email
      get :create, :user => {:username => 'dummyuser', :email => 'dummyemail@', :password => 'dummypassword', :password_confirmation => 'dummypassword'}
      response.should be_success
      created_user = assigns[:user]
      created_user.errors.should_not be_empty
      created_user.should be_new_record
    end
  end

  describe 'edit' do
    it 'should define current user for edit' do
      session = Factory.without_access_control_do_create(:session)
      get :edit, :id => session.user.id
      response.should be_success
      user_to_edit = assigns[:user]
      user_to_edit.should_not be_nil
      user_to_edit.should == session.user
    end
  end

  describe 'update' do
    it 'should remove attribute that are restricted for update' do
      user = Factory.create(:user, :username => 'oldusername', :email => 'oldemail@email.com')
      Factory.create(:session, :username => user.username, :password => user.password)

      get :update, :id => user.id, :user => {:username => 'newusername', :email => 'newemail@email.com'}

      persisted_user = User.find(user.id)
      persisted_user.username.should == 'oldusername'
      persisted_user.email.should == 'oldemail@email.com'
      response.should have_updated_resource(persisted_user, user_path(persisted_user))
    end
  end
end