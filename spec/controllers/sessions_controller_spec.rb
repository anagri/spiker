require File.dirname(__FILE__) + '/spec_helper'

describe SessionsController do
  describe 'new' do
    describe 'should assign new session object for' do
      it 'html request' do
        do_new(:get_html)
      end
      it 'xml request' do
        do_new(:get_xml)
      end

      def do_new(http_method)
        send(http_method, :new)
        assigns[:session].should_not be_nil
      end
    end
  end

  describe 'create' do
    before(:each) do
      @login_params = params_hash(:session => {:username => 'testuser', :password => 'testpass'})
    end

    describe 'should create new session object with given params for' do
      it 'html request' do
        do_successful_create(:post_html, "302")
      end

      it 'xml request' do
        do_successful_create(:post_xml, "201")
      end

      def do_successful_create(http_method, status)
        session = do_create(http_method, true)
        flash[:notice].should == 'Successfully logged in'
        response.should have_created_resource(:resource => session, :location => full_url(root_path), :status => status)
      end
    end

    describe 'should not create new session if session params invalid for' do
      it 'html request' do
        do_unsuccessful_create(:post_html)
      end
      it 'xml request' do
        do_unsuccessful_create(:post_html)
      end

      def do_unsuccessful_create(http_method)
        do_create(http_method, false)
        response.should be_success
        response.should render_template('new')
      end
    end

    def do_create(http_method, save_result)
      clear_session
      mock_valid_session = mock('session', :save => save_result)
      Session.expects(:new).with(@login_params[:session]).returns(mock_valid_session)

      send(http_method, :create, @login_params)

      assigns[:session].should == mock_valid_session
      mock_valid_session
    end

    def clear_session
      Session.stubs(:find).returns(nil)
    end
  end

  describe 'destroy' do
    describe 'should find the current session and destroy it for' do
      it 'html request' do
        do_destroy(:delete_html)
      end

      it 'xml request' do
        do_destroy(:delete_xml)
      end

      def do_destroy(http_method)
        Session.stubs(:find).returns(mock('session', :destroy => true, :user => stub('user', :role_symbols => [:user])))
        controller.expects(:reset_session)
        send(http_method, :destroy)
        flash[:notice].should == 'Successfully logged out'
        response.should be_redirect_to(full_url(root_path))
      end
    end
  end
end