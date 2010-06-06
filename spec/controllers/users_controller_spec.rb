require 'spec_helper'

describe UsersController do
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
      response.should be_redirect
      User.find_by_username('dummyuser').should_not be_nil
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
end