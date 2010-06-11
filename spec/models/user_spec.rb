require 'spec_helper'

describe User do
  describe 'valid user' do
    it 'should create user if username, password and password_confirmation provided correctly' do
      Factory.create(:user).should be_valid
    end
  end

  describe 'invalid user' do
    it 'should not create user if password is blank'do
      invalid_user = User.create(:username => 'testuser', :email => 'testemail@email.com', :password => '', :password_confirmation => '')
      invalid_user.should be_invalid
      invalid_user.errors.should have_ar_errors(:password => [:confirmation, :too_short], :password_confirmation => :too_short)
    end

    it 'should not create user if username is blank' do
      invalid_user = User.create(:username => '', :email => 'testemail@email.com', :password => 'testpass', :password_confirmation => 'testpass')
      invalid_user.should be_invalid
      invalid_user.errors.should have_ar_errors(:username => [:invalid, :too_short])
    end

    it 'should not create user if password and password_confirmation mismatch' do
      invalid_user = User.create(:username => 'testuser', :email => 'testemail@email.com', :password => 'testpass', :password_confirmation => 'diffpass')
      invalid_user.should be_invalid
      invalid_user.errors.should have_ar_errors(:password => :confirmation)
    end

    it 'should not create user if password less than 4 characters' do
      invalid_user = User.create(:username => 'testuser', :email => 'testuser@email.com', :password => '123', :password_confirmation => '123')
      invalid_user.should be_invalid
      invalid_user.errors.should have_ar_errors(:password => :too_short, :password_confirmation => :too_short)
    end
  end
end