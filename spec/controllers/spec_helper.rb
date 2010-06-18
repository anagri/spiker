require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

Spec::Runner.configure do |config|
  config.include Authorization::TestHelper
end

Dir[File.expand_path(File.join(File.dirname(__FILE__), 'support', '**', '*.rb'))].each {|f| require f}

