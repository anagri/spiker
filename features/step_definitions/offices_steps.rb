Given /^a branch office "([^\"]*)" exists under "([^\"]*)"$/ do |new_office, parent_office|
  Factory.create(:office, :name => new_office, :parent => Office.find_by_name(parent_office))
end