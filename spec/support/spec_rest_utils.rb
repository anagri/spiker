require 'spec_helper'

def assert_restful_routing(resource)
  resources = resource.pluralize
  send(:"#{resources}_path").should == "/#{resources}"
  send(:"new_#{resource}_path").should == "/#{resources}/new"
  send(:"edit_#{resource}_path", 1).should == "/#{resources}/1/edit"
  send(:"#{resource}_path", 1).should == "/#{resources}/1"
end