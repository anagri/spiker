#require 'ruby-debug'
require 'fakeweb'
require 'factory_girl'
require 'authlogic/test_case'
require 'declarative_authorization/maintenance'

Dir.glob(File.dirname(__FILE__) + '/../../spec/factories/*_factory.rb').sort.each do |factory|
  require factory.gsub(/\.rb/, '')
end

Dir.glob(File.dirname(__FILE__) + '/../../spec/support/**/*.rb').sort.each do |factory|
  require factory.gsub(/\.rb/, '')
end

FakeWeb.allow_net_connect = false

#FakeWeb.register_uri(:any, "http://smtp.google.com", :body => "Mail delivered successfully")

#utility methods aliased
#alias_method :iv_g, :instance_variable_get
#alias_method :iv_s, :instance_variable_set

World(ActionController::Translation)

