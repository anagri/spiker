require File.dirname(__FILE__) + '/spec_helper'

describe User do
  before(:each) do
    @office_type = Factory.without_access_control_do_build(:office_type)
    @office = Factory.without_access_control_do_build(:office, :office_type => @office_type)
  end

  describe 'valid user' do
    it 'should be valid user if username, email, office, password and password_confirmation provided correctly' do
      User.new(:username => 'testuser', :password => 'testpass', :password_confirmation => 'testpass', :email => 'user@test.com', :office => @office, :role => Role::STAFF).should be_valid
    end

    it 'should be valid admin if username, email, office, password and password_confirmation provided correctly and belonging to head office ' do
      User.new(:username => 'admin', :password => 'adminpass', :password_confirmation => 'adminpass', :email => 'admin@test.com', :office => @office, :role => Role::ADMIN).should be_valid
    end
  end

  describe 'invalid user' do
    it 'should be invalid user if password is blank'do
      invalid_user = User.without_access_control_do_new(:username => 'testuser', :email => 'testemail@email.com', :password => '', :password_confirmation => '', :office => @office, :role => Role::STAFF)
      invalid_user.should have_ar_errors(:password => [:confirmation, :too_short], :password_confirmation => :too_short)
    end

    it 'should be invalid user if username is blank' do
      invalid_user = User.without_access_control_do_new(:username => '', :email => 'testemail@email.com', :password => 'testpass', :password_confirmation => 'testpass', :office => @office, :role => Role::STAFF)
      invalid_user.should have_ar_errors(:username => [:invalid, :too_short])
    end

    it 'should be invalid user if password and password_confirmation mismatch' do
      invalid_user = User.without_access_control_do_new(:username => 'testuser', :email => 'testemail@email.com', :password => 'testpass', :password_confirmation => 'diffpass', :office => @office, :role => Role::STAFF)
      invalid_user.should have_ar_errors(:password => :confirmation)
    end

    it 'should be invalid user if password less than 4 characters' do
      invalid_user = User.without_access_control_do_new(:username => 'testuser', :email => 'testuser@email.com', :password => '123', :password_confirmation => '123', :office => @office, :role => Role::STAFF)
      invalid_user.should have_ar_errors(:password => :too_short, :password_confirmation => :too_short)
    end

    it 'should be invalid user if office is not present' do
      invalid_user = User.without_access_control_do_new(:username => 'testuser', :email => 'testuser@email.com', :password => 'testpass', :password_confirmation => 'testpass', :role => Role::STAFF)
      invalid_user.should have_ar_errors(:office => :blank)
    end

    it 'should be invalid user if role is not present' do
      invalid_user = User.without_access_control_do_new(:username => 'testuser', :email => 'testuser@email.com', :password => 'testpass', :password_confirmation => 'testpass', :office => @office)
      invalid_user.should have_ar_errors(:role => :inclusion)
    end

    it 'should be invalid user if role is not valid' do
      invalid_user = User.without_access_control_do_new(:username => 'testuser', :email => 'testuser@email.com', :password => 'testpass', :password_confirmation => 'testpass', :role => 'none', :office => @office)
      invalid_user.should have_ar_errors(:role => :inclusion)
    end

    it 'should be invalid admin if not assigned root office' do
      branch_office_type = Factory.without_access_control_do_build(:office_type, :parent => @office_type)
      branch_office = Factory.without_access_control_do_build(:office, :parent => @office)
      invalid_user = User.without_access_control_do_new(:username => 'testuser', :email => 'testuser@email.com', :password => 'testpass', :password_confirmation => 'testpass', :role => Role::ADMIN, :office => branch_office)
      invalid_user.should have_ar_errors(:office => :head_office_for_admin_role)
    end

    it 'should be invalid if username contains spaces and special symbols' do
      ['test user', 'testuser@'].each do |username|
        invalid_user = User.without_access_control_do_new(:username => username, :email => 'testuser@email.com', :password => 'testpass', :password_confirmation => 'testpass', :role => 'none', :office => @office, :role => Role::STAFF)
        invalid_user.should have_ar_errors(:username => :invalid)
      end
    end

    it 'should be valid if username contains letters, numbers and underscore' do
      invalid_user = User.without_access_control_do_new(:username => 'test_user', :email => 'testuser@email.com', :password => 'testpass', :password_confirmation => 'testpass', :role => 'none', :office => @office, :role => Role::STAFF)
      invalid_user.should be_valid
    end
  end


  describe 'password reset email' do
    it 'should reset perishable token and invoke notifier to send email with instructions' do
      user = stub_model(User, :reset_perishable_token! => true, :email => 'user@test.com', :perishable_token => 'abcd1234')
      Notifier.expects(:deliver_password_reset_instructions).with({:email => user.email, :id => user.perishable_token})
      Authorization::Maintenance.with_user(user) do
        user.deliver_password_reset_instructions!({})
      end
    end
  end

  describe 'role symbols' do
    it 'should return role_symbols as role in array form' do
      user = stub_model(User, :role => 'staff')
      user.role_symbols.should == [:staff]
    end
  end
end