require File.dirname(__FILE__) + '/spec_helper'

describe 'Named Routes' do
  describe 'Session' do
    it 'should generate login_path' do
      login_path.should == '/login'
    end

    it 'should generate logout_path' do
      logout_path.should == '/logout'
    end

    it 'should generate logout_path' do
      dashboard_path.should == '/dashboard'
    end
  end

  it 'should generate restful user resources routes' do
    assert_restful_routing("user")
  end

  it 'should generate restful office resources routes' do
    assert_restful_routing("office")
  end

  it 'should generate restful office_type resources routes' do
    assert_restful_routing("office_type")
  end

  it 'should generate restful client_type resources routes' do
    assert_restful_routing("client_type")
  end

  it 'should generate restful client_type resources routes' do
    assert_restful_routing("password_reset")
  end
end
