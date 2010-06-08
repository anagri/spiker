require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

require 'authlogic/test_case'
require 'declarative_authorization/maintenance'

Spec::Runner.configure do |config|
  config.include Authorization::TestHelper
end

