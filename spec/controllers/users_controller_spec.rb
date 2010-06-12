require File.dirname(__FILE__) + '/spec_helper'


describe UsersController do
  def login_user
    login
    current_user = user_session(nil, {:first_name => 'oldfirstname', :last_name => 'oldlastname'}).user
    User.expects(:find).with(current_user.id.to_s).returns(current_user)
    return current_user
  end

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
      @user_params = params_hash(:username => 'testuser')
    end

    describe 'should create new user for valid' do
      before(:each) do
        @stub_user = stub('user', :id => 1, :save => true)
        User.expects(:new).with(@user_params).returns(@stub_user)
      end

      it 'html request' do
        get_html :create, :user => @user_params
        response.should have_created_resource(:resource => @stub_user, :location => user_path(@stub_user), :status => "302")
      end

      it 'xml request' do
        get_xml :create, :user => @user_params
        response.should have_created_resource(:resource => @stub_user, :location => user_path(@stub_user), :status => "201")
      end
    end

    describe 'shoud not create new user for invalid' do
      before(:each) do
        @stub_user = stub('user', :id => 1, :save => false)
        User.expects(:new).with(@user_params).returns(@stub_user)
      end

      it 'html request' do
        get_html :create, :user => @user_params
        response.should be_success
        assigns[:user].should == @stub_user
        flash[:error].should == 'Error while doing registration'
        response.should render_template('new')
      end

      it 'xml request' do
        get_xml :create, :user => @user_params
        response.should be_success
        flash[:error].should == 'Error while doing registration'
        assigns[:user].should == @stub_user
        response.should render_template('new')
      end
    end

    it 'should return error if user not created' do
    end
  end

  describe 'edit' do
    describe 'should define current user for edit and render template for' do
      it 'html request' do
        do_edit(:get_html)
      end

      it 'xml request' do
        do_edit(:get_xml)
      end

      def do_edit(http_method)
        current_user = login_user
        send(http_method, :edit, :id => current_user.id)
        response.should be_success
        user_to_edit = assigns[:user]
        user_to_edit.should_not be_nil
        user_to_edit.should == current_user
        response.should render_template('new')
      end
    end
  end

  describe 'update' do
    before(:all) do
      @restricted_attr = params_hash(:username => 'newusername', :email => 'newemail@email.com')
      @unrestricted_attr = params_hash(:first_name => 'newfirstname', :last_name => 'newlastname')
      @update_attr = @unrestricted_attr.merge(@restricted_attr)
    end

    describe 'should remove attribute that are restricted for update for' do
      it 'html request' do
        do_successful_update(:get_html, @unrestricted_attr)
      end

      it 'xml request' do
        do_successful_update(:get_xml, @unrestricted_attr)
      end
    end

    describe 'should update unrestricted user information' do

    end

    it 'should render edit screen if update failed' do
      current_user = login_user
      current_user.expects(:update_attributes).with(@unrestricted_attr).returns(false)
      get :update, :id => current_user.id, :user => @update_attr

      response.should render_template('edit')
    end

    def do_successful_update(http_method, user_update_params = @update_attr, user_update_expected_param = @unrestricted_attr)
      current_user = login_user
      current_user.expects(:update_attributes).with(user_update_expected_param).returns(true)

      send(http_method, :update, :id => current_user.id, :user => user_update_params)

      response.should have_updated_resource(current_user, full_url(user_path(current_user)))
    end
  end
end
