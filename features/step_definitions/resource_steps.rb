# visit the page for resource using restful url /users/1
# added processing options
When /^(?:|I )visit the "([^"]*)" page for "([^"]*)"$/ do |resource, identifier|
  visit send("#{resource}_path".to_sym, process(identifier))
end
