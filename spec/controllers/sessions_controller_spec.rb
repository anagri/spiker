require File.dirname(__FILE__) + '/spec_helper'

describe SessionsController do
  describe 'new' do
    it 'should assign new session object' do
      get :new
      assigns[:session].should_not be_nil
    end
  end

  describe 'create' do
    before(:each) do
      Authlogic::Session::Base.controller = Authlogic::ControllerAdapters::RailsAdapter.new(controller)
    end

    it 'should create new session object with given params' do
      Session.find.try(:destroy)
      user = Factory.create(:user)
      post :create, :session => {:username => user.username, :password => user.password}
      response.should be_redirect
      Session.find.should_not be_nil
    end

    it 'should not create new session if params are invalid' do
      Session.find.try(:destroy)
      #no user setup
      post :create, :session => {:username => "dummyuser", :password => "dummypassword"}
      response.should be_success
      session = assigns[:session]
      session.should_not be_nil
      session.errors.should_not be_empty
      Session.find.should be_nil
    end
  end
end