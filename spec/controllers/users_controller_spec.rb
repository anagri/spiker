require File.dirname(__FILE__) + '/spec_helper'


describe UsersController do
  before(:each) do
    activate_authlogic
  end

  describe 'new' do
    describe 'should let guest define new user using' do
      it 'html request' do
        do_successful_new(:get_html_with, guest)
      end
      it 'xml request' do
        do_successful_new(:get_xml_with, guest)
      end
    end

    describe 'should not let user define new user using' do
      it 'html request' do
        do_new(:get_html_with, user)
        response.should be_unauthorized
      end

      it 'xml request' do
        do_new(:get_html_with, user)
        response.should be_unauthorized
      end
    end

    def do_successful_new(http_method, user)
      do_new(http_method, user)
      response.should be_success
      assigns[:user].should_not be_nil
    end

    def do_new(http_method, user)
      send(http_method, user, :new)
    end
  end

  describe 'create' do
    before(:each) do
      @user_params = params_hash(:username => 'testuser')
    end

    describe 'should let guest create new user for valid' do
      before(:each) do
        @stub_user = stub('user', :id => 1, :save => true)
        User.expects(:new).with(@user_params).returns(@stub_user)
      end

      it 'html request' do
        post_html_with guest, :create, :user => @user_params
        response.should have_created_resource(:resource => @stub_user, :location => user_path(@stub_user), :status => "302")
      end

      it 'xml request' do
        post_xml_with guest, :create, :user => @user_params
        response.should have_created_resource(:resource => @stub_user, :location => user_path(@stub_user), :status => "201")
      end
    end

    describe 'shoud not let guest create new user for invalid' do
      before(:each) do
        @stub_user = stub('user', :id => 1, :save => false)
        User.expects(:new).with(@user_params).returns(@stub_user)
      end

      it 'html request' do
        do_unsucessful_create(:post_html_with)
      end

      it 'xml request' do
        do_unsucessful_create(:post_xml_with)
      end

      def do_unsucessful_create(http_method)
        send(http_method, guest, :create, :user => @user_params)
        response.should be_success
        assigns[:user].should == @stub_user
        flash[:error].should == 'Error while doing registration'
        response.should render_template('new')
      end
    end

    describe 'should not let user create new user using' do
      it 'html request' do
        send(:post_html_with, user, :create)
        response.should be_unauthorized
      end
      it 'xml request' do
        send(:post_xml_with, user, :create)
        response.should be_unauthorized
      end
    end
  end

  describe 'edit' do
    describe 'should let user edit its profile using' do
      it 'html request' do
        do_edit_with_user(:get_html_with)
      end

      it 'xml request' do
        do_edit_with_user(:get_xml_with)
      end
    end

    describe 'should not let user edit others profile using' do
      it 'html request' do
        do_edit_other_user_profile(:get_html_with)
      end

      it 'html request' do
        do_edit_other_user_profile(:get_xml_with)
      end

      def do_edit_other_user_profile(http_method)
        other_user = user
        User.stubs(:find).with(other_user.id).returns(other_user)
        do_edit(http_method, user, other_user.id)
        response.should be_unauthorized
      end
    end

    def do_edit_with_user(http_method)
      current_user = user
      do_edit(http_method, current_user, current_user.id)
      response.should be_success
      user_to_edit = assigns[:user]
      user_to_edit.should_not be_nil
      user_to_edit.should == current_user
      response.should render_template('new')
    end

    def do_edit_with_guest(http_method)
      do_edit(http_method, guest, 1)
      response.should be_unauthorized
    end

    def do_edit(http_method, user, user_id_to_be_edited)
      send(http_method, user, :edit, :id => user_id_to_be_edited)
    end
  end

  describe 'update' do
    before(:all) do
      @restricted_attr = params_hash(:username => 'newusername', :email => 'newemail@email.com')
      @unrestricted_attr = params_hash(:first_name => 'newfirstname', :last_name => 'newlastname')
      @update_attr = @unrestricted_attr.merge(@restricted_attr)
    end

    describe 'should let user update and auto remove attribute that are restricted for update using' do
      it 'html request' do
        do_successful_update(:get_html, @unrestricted_attr)
      end

      it 'xml request' do
        do_successful_update(:get_xml, @unrestricted_attr)
      end
    end

    describe 'should let user update unrestricted profile information using' do
      it 'html request' do
        do_successful_update(:get_html)
      end

      it 'xml request' do
        do_successful_update(:get_xml)
      end
    end

    describe 'should not let guest update user information using' do
      it 'html request' do
        send(:get_html_with, guest, :update, :id => user.id, :user => @update_params)
        response.should be_unauthorized
      end

      it 'xml request' do
        send(:get_xml_with, guest, :update, :id => user.id, :user => @update_params)
        response.should be_unauthorized
      end
    end

    it 'should let user render edit screen if update failed' do
      current_user = user
      current_user.expects(:update_attributes).with(@unrestricted_attr).returns(false)
      get_html_with current_user, :update, :id => current_user.id, :user => @update_attr
      response.should render_template('edit')
    end

    def do_successful_update(http_method, user_update_params = @update_attr, user_update_expected_param = @unrestricted_attr)
      current_user = user
      current_user.expects(:update_attributes).with(user_update_expected_param).returns(true)

      send("#{http_method}_with", current_user, :update, :id => current_user.id, :user => user_update_params)

      response.should have_updated_resource(current_user, full_url(user_path(current_user)))
    end

    def update(http_method, user, user_update_params = @update_attr)
      send("#{http_method}_with", user, :update, :id => current_user.id, :user => user_update_params)
    end
  end
end
