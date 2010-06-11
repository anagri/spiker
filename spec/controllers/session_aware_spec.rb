require File.dirname(__FILE__) + '/spec_helper'

class StubController < ApplicationController
end

describe 'SessionAware', :type => :controller do
  controller_name :stub
  include SessionAware

  it 'should get current user from session' do
    user = stub('user')
    Session.expects(:find).returns(stub('session', :user => user))
    current_user.should == user
  end
end

