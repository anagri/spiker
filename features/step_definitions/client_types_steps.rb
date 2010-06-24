When /^a client type "([^\"]*)" exists(?: with parent(?:|s) "([^\"]*)")?(?: and assigned to "([^\"]*)")?$/ do |client_type_name, parents, assignment_var|
  assignment_var = assignment_var || "@client_type"
  parents = parents && parents.split(",") # split the parent ids
  parents = parents && parents.collect {|parent| instance_variable_get(parent.to_sym).id} # if root is also not defined, assign nil, otherwise collect root/parent ids
  client_type = Factory.without_access_control_do_create(:client_type, :name => client_type_name || "Client Type", :parent_ids => parents)
  instance_variable_set(assignment_var.to_sym, client_type)
end