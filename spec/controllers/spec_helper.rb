require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

require 'authlogic/test_case'
require 'declarative_authorization/maintenance'

Spec::Runner.configure do |config|
  config.include Authorization::TestHelper
end

Dir[File.expand_path(File.join(File.dirname(__FILE__), 'support', '**', '*.rb'))].each {|f| require f}

def current_user(stubs = {})
  @current_user ||= stub_model(User, stubs)
end

def user_session(stubs = {}, user_stubs = {})
  @session ||= stub('session', {:user => current_user(user_stubs)}.merge(stubs))
end

def login(session_stubs = {}, user_stubs = {})
  Session.stubs(:find).returns(user_session(session_stubs, user_stubs))
end

def logout
  @session = nil
end

