require File.dirname(__FILE__) + '/spec_helper'

describe DashboardController do
  before(:each) do
    activate_authlogic
  end

  describe 'authorization' do
    describe 'for user' do
      before(:each) do
        @user = staff
        @allowed_actions = all_actions(controller)
        @navigate_params = {:navigate => {:to => offices_path}}
        @navigate_expectation = be_redirect_to(offices_url)
      end

      it_should_behave_like "authorized controller"
    end

    describe 'for guest' do
      before(:each) do
        @user = guest
        @allowed_actions = none_actions
        @unauthorized_access_expectation = be_redirect_to(root_url)
      end

      it_should_behave_like "authorized controller"
    end
  end
end