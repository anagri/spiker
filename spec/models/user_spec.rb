require 'spec_helper'

describe User do
  describe 'valid user' do
    it 'should create user if username, password and password_confirmation provided correctly' do
      Factory.create(:user).should be_valid
    end
  end

  describe 'invalid user' do
    it 'should not create user if password is blank'do
      User.create(:username => 'testuser', :password => '', :password_confirmation => '').should be_invalid
    end

    it 'should not create user if username is blank' do
      User.create(:username => '', :password => 'testpass', :password_confirmation => 'testpass').should be_invalid
    end

    it 'should not create user if password and password_confirmation mismatch' do
      User.create(:username => 'testuser', :password => 'testpass', :password_confirmation => 'diffpass').should be_invalid
    end

    it 'should not create user if password less than 4 characters' do
      user = User.create(:username => 'testuser', :password => '123', :password_confirmation => '123')
      user.should be_invalid
      user.should have_errors([:password, :password_confirmation])
    end
  end
end