require 'spec_helper'

describe User do
  describe 'valid user' do
    it 'should create user if username, password and password_confirmation provided correctly'
  end

  describe 'invalid user' do
    it 'should not create user if password is blank'
    it 'should not create user if username is blank'
    it 'should not create user if password is blank'
    it 'should not create user if password and password_confirmation mismatch'
    it 'should not create user if password less than 4 characters'
  end
end