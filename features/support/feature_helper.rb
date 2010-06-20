#require 'ruby-debug'
require 'factory_girl'
require 'authlogic/test_case'
require 'declarative_authorization/maintenance'

Dir.glob(File.dirname(__FILE__) + '/../../spec/factories/*_factory.rb').sort.each do |factory|
  require factory.gsub(/\.rb/, '')
end

Dir.glob(File.dirname(__FILE__) + '/../../spec/support/**/*.rb').sort.each do |factory|
  require factory.gsub(/\.rb/, '')
end

World(ActionController::Translation)