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
    before(:each) do
      @user_params = HashWithIndifferentAccess.new(:username => 'testuser')
    end

    it 'should create new user' do
      stub_user = stub('user', :id => 1, :save => true)
      User.expects(:new).with(@user_params).returns( stub_user)
      get :create, :user => @user_params
      response.should have_created_resource(stub_user, user_path(stub_user.id))
    end

    it 'should return error if user not created' do
      stub_user = stub('user', :id => 1, :save => false)
      User.expects(:new).with(@user_params).returns(stub_user)
      get :create, :user => @user_params
      response.should be_success
      created_user = assigns[:user]
      created_user.should == stub_user
      flash[:error].should == 'Error while doing registration'
      response.should render_template('new')
    end
  end

  describe 'edit' do
    it 'should define current user for edit' do
      login
      current_user = user_session.user
      User.expects(:find).with(current_user.id.to_s).returns(current_user)
      get :edit, :id => current_user.id
      response.should be_success
      user_to_edit = assigns[:user]
      user_to_edit.should_not be_nil
      user_to_edit.should == current_user
    end
  end

  describe 'update' do
    it 'should remove attribute that are restricted for update' do
      login
      current_user = user_session.user
      User.expects(:find).with(current_user.id.to_s).returns(current_user)
      current_user.expects(:update_attributes).with({}).returns(true)

      get :update, :id => current_user.id, :user => {:username => 'newusername', :email => 'newemail@email.com'}

      response.should have_updated_resource(current_user, user_path(current_user))
    end
  end
end
