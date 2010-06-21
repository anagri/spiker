require File.dirname(__FILE__) + '/spec_helper'

describe SessionsController do
  describe 'new' do
    before(:each) do
      activate_authlogic
    end

    describe 'should let guest assign new session object for' do
      it 'html request' do
        do_new(:get_html_with, guest)
        response.should be_success
      end

      it 'xml request' do
        do_new(:get_xml_with, guest)
        response.should be_success
      end
    end

    describe 'should not let user assign new session object for' do
      it 'html request' do
        do_new(:get_html_with, staff)
        response.should be_unauthorized
      end
      it 'xml request' do
        do_new(:get_xml_with, staff)
        response.should be_unauthorized
      end
    end

    def do_new(http_method, user)
      send(http_method, user, :new, options)
      assigns[:session].should_not be_nil
    end
  end

  describe 'create' do
    before(:each) do
      @login_params = params_hash(:session => {:username => 'testuser', :password => 'testpass'})
    end

    describe 'should let guest create new session object with given params for' do
      it 'html request' do
        do_successful_create(:post_html, "302")
      end

      it 'xml request' do
        do_successful_create(:post_xml, "201")
      end

      def do_successful_create(http_method, status)
        session = do_create_with_guest(http_method, true)
        flash[:info].should == 'sessions.create.success'
        response.should have_created_resource(:resource => session, :location => full_url(root_path), :status => status)
      end
    end

    describe 'should not let guest create new session if session params invalid for' do
      it 'html request' do
        do_unsuccessful_create(:post_html)
      end
      it 'xml request' do
        do_unsuccessful_create(:post_html)
      end

      def do_unsuccessful_create(http_method)
        do_create_with_guest(http_method, false)
        response.should be_success
        response.should render_template('new')
        flash[:error].should == 'sessions.create.error'
      end
    end

    describe 'should not let user create new session for' do
      it 'html request' do
        do_create_with_user(:post_html)
      end

      it 'xml request' do
        do_create_with_user(:post_xml)
      end
    end

    def do_create_with_guest (http_method, save_result)
      mock_valid_session = mock('session', :without_access_control_do_save => save_result)
      Session.expects(:new).with(@login_params[:session]).returns(mock_valid_session)

      do_create(http_method, guest)

      assigns[:session].should == mock_valid_session
    end

    def do_create_with_user(http_method)
      do_create(http_method, staff)
      response.should be_unauthorized
      flash[:error].should == unauthorized_msg_key('create')
    end

    def do_create(http_method, user)
      send("#{http_method}_with", user, :create, @login_params)
    end
  end

  describe 'destroy' do
    describe 'should let user destroy session for' do
      it 'html request' do
        do_destroy(:delete_html)
      end

      it 'xml request' do
        do_destroy(:delete_xml)
      end

      def do_destroy(http_method)
        controller.expects(:reset_session)
        login(staff, {:destroy => true})
        send(http_method, :destroy)
        flash[:info].should == 'sessions.destroy.success'
        response.should be_redirect_to(full_url(root_path))
      end
    end
  end
end