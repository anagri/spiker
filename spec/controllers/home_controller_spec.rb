require File.dirname(__FILE__) + '/spec_helper'

describe HomeController do
  before(:each) do
    activate_authlogic
  end

  describe 'authorization' do
    before(:each) do
      @controller_class = HomeController
      @resource_id = nil
    end
    it_should_behave_like "unauthorized controller"
  end
end