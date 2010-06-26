require File.dirname(__FILE__) + '/spec_helper'

describe HomeController do
  before(:each) do
    activate_authlogic
  end

  describe 'authorization' do
    describe 'for guest' do
      before(:each) do
        @user = guest
        @allowed_actions = index_actions
        @restricted_actions = none_actions
      end

      it_should_behave_like 'authorized controller'
    end

    describe 'for user' do
      before(:each) do
        @user = staff
        @allowed_actions = none_actions
        @unauthorized_access_expectation = be_redirect_to(dashboard_url)
      end

      it_should_behave_like 'authorized controller'
    end
  end
end