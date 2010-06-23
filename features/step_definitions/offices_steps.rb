When /^(?:|I )select #"([^\"]*)" from "([^\"]*)"$/ do |assignment_var, field|
  Then %Q{I select "#{eval(assignment_var)}" from "#{field}"}
end

When /^(?:|a )office type exists(?:| and assigned to "([^\"]*)")(?:| with parent "([^\"]*)")$/ do |assignment_var, parent_var|
  var_name = (assignment_var || "@office_type").to_sym
  office_type = parent_var.nil? ? get_head_office_type : Factory.without_access_control_do_create(:office_type, :parent => instance_variable_get(parent_var))
  instance_variable_set(var_name.to_sym, office_type)
end

When /^(?:|a )office exists(?:| and assigned to "([^\"]*)")(?:| with parent "([^\"]*)")$/ do |assignment_var, parent_var|
  var_name = (assignment_var || "@office").to_sym
  office = parent_var.nil? ? get_head_office : Factory.without_access_control_do_create(:office, :parent => instance_variable_get(parent_var))
  instance_variable_set(var_name, office)
end

private
def get_head_office_type
  OfficeType.head || Factory.without_access_control_do_create(:office_type)
end

def get_head_office
  Office.root || Factory.without_access_control_do_create(:office)
rescue Exception => e
  e.backtrace.each {|str| p str}
end
