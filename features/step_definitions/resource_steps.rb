
# visit the page for resource using restful url /users/1
When /^(?:|I )visit the "([^"]*)" page for (\d+)$/ do |resource, id|
  visit send("#{resource}_path".to_sym, id)
end
