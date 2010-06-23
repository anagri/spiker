require File.dirname(__FILE__) + '/spec_helper'

describe User do
  before(:each) do
    Factory.without_access_control_do_create(:office_type)
    Factory.without_access_control_do_create(:office)
  end

  describe 'valid user' do
    it 'should create user if username, password and password_confirmation provided correctly' do
      Factory.create(:user).should be_valid
    end
  end

  describe 'invalid user' do
    it 'should not create user if password is blank'do
      invalid_user = User.create(:username => 'testuser', :email => 'testemail@email.com', :password => '', :password_confirmation => '', :office => Office.root, :role => Role::STAFF)
      assert_invalid_record(invalid_user, :password => [:confirmation, :too_short], :password_confirmation => :too_short)
    end

    it 'should not create user if username is blank' do
      invalid_user = User.create(:username => '', :email => 'testemail@email.com', :password => 'testpass', :password_confirmation => 'testpass', :office => Office.root, :role => Role::STAFF)
      assert_invalid_record(invalid_user, :username => [:invalid, :too_short])
    end

    it 'should not create user if password and password_confirmation mismatch' do
      invalid_user = User.create(:username => 'testuser', :email => 'testemail@email.com', :password => 'testpass', :password_confirmation => 'diffpass', :office => Office.root, :role => Role::STAFF)
      assert_invalid_record(invalid_user, :password => :confirmation)
    end

    it 'should not create user if password less than 4 characters' do
      invalid_user = User.create(:username => 'testuser', :email => 'testuser@email.com', :password => '123', :password_confirmation => '123', :office => Office.root, :role => Role::STAFF)
      assert_invalid_record(invalid_user, :password => :too_short, :password_confirmation => :too_short)
    end

    it 'should not create user if office is not present' do
      invalid_user = User.create(:username => 'testuser', :email => 'testuser@email.com', :password => 'testpass', :password_confirmation => 'testpass', :role => Role::STAFF)
      assert_invalid_record(invalid_user, :office => :blank)
    end

    it 'should not create user if role is not present' do
      invalid_user = User.create(:username => 'testuser', :email => 'testuser@email.com', :password => 'testpass', :password_confirmation => 'testpass', :office => Office.root)
      assert_invalid_record(invalid_user, :role => :inclusion)
    end

    it 'should not create user if role is not valid' do
      invalid_user = User.create(:username => 'testuser', :email => 'testuser@email.com', :password => 'testpass', :password_confirmation => 'testpass', :role => 'none', :office => Office.root)
      assert_invalid_record(invalid_user, :role => :inclusion)
    end
  end
end