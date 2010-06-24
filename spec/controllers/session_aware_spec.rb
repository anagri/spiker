require File.dirname(__FILE__) + '/spec_helper'

class StubController < ApplicationController
  include SessionAware
end

describe 'SessionAware', :type => :controller do
  controller_name :stub

  it 'should get current user from session' do
    user = stub('user')
    Session.expects(:find).returns(stub('session', :user => user))
    controller.current_user.should == user
  end
end

