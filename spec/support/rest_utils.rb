def assert_restful_routing(resource, skip = [])
  resources = resource.pluralize
  send(:"#{resources}_path").should == "/#{resources}" unless skip.include?(:index)
  send(:"new_#{resource}_path").should == "/#{resources}/new" unless skip.include?(:new)
  send(:"edit_#{resource}_path", 1).should == "/#{resources}/1/edit" unless skip.include?(:edit)
  send(:"#{resource}_path", 1).should == "/#{resources}/1" unless skip.include?(:show)
end