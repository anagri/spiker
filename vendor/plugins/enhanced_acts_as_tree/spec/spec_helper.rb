begin
  require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
rescue LoadError
  puts "You need to install rspec in your base app"
  exit
end

ActiveRecord::Base.logger = Logger.new(RAILS_ROOT + "/log/debug.log")

