require 'factory_girl'

Dir.glob(File.dirname(__FILE__) + '/../../spec/factories/*_factory.rb').sort.each do |factory|
  require factory.gsub(/\.rb/, '')
end
