When /^(?:|I )visit the "([^"]*)" page for (\d+)$/ do |resource, id|
  visit send("#{resource}_path".to_sym, id)
end