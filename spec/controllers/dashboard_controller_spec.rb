require File.dirname(__FILE__) + '/spec_helper'

describe DashboardController do
  before(:each) do
    activate_authlogic
  end

  describe 'authorization' do
    before(:each) do
      @user = staff
      @unauthorized_access_expectation = be_redirect_to(root_url)
    end

    it_should_behave_like "authorized controller"
  end
end