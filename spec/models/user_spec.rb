require File.dirname(__FILE__) + '/spec_helper'

describe User do
  before(:each) do
    Factory.without_access_control_do_create(:office_type)
    Factory.without_access_control_do_create(:office)
  end

  describe 'valid user' do
    it 'should create user if username, password and password_confirmation provided correctly' do
      Factory.without_access_control_do_create(:user).should be_valid
    end

    it 'should create admin if belonging to head office provided correctly' do
      Factory.without_access_control_do_create(:user, :role => Role::ADMIN, :office => Office.root).should be_valid
    end
  end

  describe 'invalid user' do
    it 'should not create user if password is blank'do
      invalid_user = User.without_access_control_do_create(:username => 'testuser', :email => 'testemail@email.com', :password => '', :password_confirmation => '', :office => Office.root, :role => Role::STAFF)
      assert_invalid_record(invalid_user, :password => [:confirmation, :too_short], :password_confirmation => :too_short)
    end

    it 'should not create user if username is blank' do
      invalid_user = User.without_access_control_do_create(:username => '', :email => 'testemail@email.com', :password => 'testpass', :password_confirmation => 'testpass', :office => Office.root, :role => Role::STAFF)
      assert_invalid_record(invalid_user, :username => [:invalid, :too_short])
    end

    it 'should not create user if password and password_confirmation mismatch' do
      invalid_user = User.without_access_control_do_create(:username => 'testuser', :email => 'testemail@email.com', :password => 'testpass', :password_confirmation => 'diffpass', :office => Office.root, :role => Role::STAFF)
      assert_invalid_record(invalid_user, :password => :confirmation)
    end

    it 'should not create user if password less than 4 characters' do
      invalid_user = User.without_access_control_do_create(:username => 'testuser', :email => 'testuser@email.com', :password => '123', :password_confirmation => '123', :office => Office.root, :role => Role::STAFF)
      assert_invalid_record(invalid_user, :password => :too_short, :password_confirmation => :too_short)
    end

    it 'should not create user if office is not present' do
      invalid_user = User.without_access_control_do_create(:username => 'testuser', :email => 'testuser@email.com', :password => 'testpass', :password_confirmation => 'testpass', :role => Role::STAFF)
      assert_invalid_record(invalid_user, :office => :blank)
    end

    it 'should not create user if role is not present' do
      invalid_user = User.without_access_control_do_create(:username => 'testuser', :email => 'testuser@email.com', :password => 'testpass', :password_confirmation => 'testpass', :office => Office.root)
      assert_invalid_record(invalid_user, :role => :inclusion)
    end

    it 'should not create user if role is not valid' do
      invalid_user = User.without_access_control_do_create(:username => 'testuser', :email => 'testuser@email.com', :password => 'testpass', :password_confirmation => 'testpass', :role => 'none', :office => Office.root)
      assert_invalid_record(invalid_user, :role => :inclusion)
    end

    it 'should not create admin if not assigned root office' do
      branch_office_type = Factory.without_access_control_do_create(:office_type, :parent => OfficeType.root)
      branch_office = Factory.without_access_control_do_create(:office, :parent => Office.root, :office_type => branch_office_type)
      invalid_user = User.without_access_control_do_create(:username => 'testuser', :email => 'testuser@email.com', :password => 'testpass', :password_confirmation => 'testpass', :role => Role::ADMIN, :office => branch_office)
      assert_invalid_record(invalid_user, :office => :head_office_for_admin_role)
    end
  end
end