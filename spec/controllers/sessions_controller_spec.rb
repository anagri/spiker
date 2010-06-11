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
      @login_params = params_hash(:session => {:username => 'testuser', :password => 'testpass'})
    end

    it 'should create new session object with given params' do
      clear_session
      mock_valid_session = mock('session', :save => true)
      Session.expects(:new).with(@login_params[:session]).returns(mock_valid_session)

      post :create, @login_params
      flash[:notice].should == 'Successfully logged in'
      response.should be_redirect
      assigns[:session].should == mock_valid_session
    end

    it 'should not create new session if session params invalid' do
      clear_session
      mock_invalid_session = mock('session', :save => false)
      Session.expects(:new).with(@login_params[:session]).returns(mock_invalid_session)

      post :create, @login_params
      response.should be_success
      session = assigns[:session]
      session.should == mock_invalid_session
    end

    def clear_session
      Session.stubs(:find).returns(nil)
    end
  end

  describe 'destroy' do
    it 'should find the current session and destroy it' do
      Session.stubs(:find).returns(mock('session', :destroy => true, :user => stub('user')))
      delete :destroy
      flash[:notice].should == 'Successfully logged out'
      response.should be_redirect_to(full_url(root_path))
    end
  end
end