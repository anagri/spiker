# verify the i18n message
#Then /^(?:|I )should see msg "([^\"]*)"$/ do |msg_key|
#  Then %Q{should see "#{t(msg_key)}"}
#end

When /^(?:|I )visit the "users" page for user "([^\"]*)"$/ do |username|
  user = User.find_by_username(username)
  steps %Q{
    Then I visit the "users" page for #{user.id} 
  }
end

# access i18n controls
When /^(?:|I )press t "([^\"]*)"$/ do |key|
  Then %Q{I press "#{t(key)}"}
end

# access i18n links
When /^(?:|I )follow #"([^\"]*)"$/ do |var_str|
  Then %Q{I follow "#{process(var_str)}"}
end

When /^(?:|I )fill in "([^\"]*)" with current user$/ do |field|
  Then %Q{I fill in "#{field}" with "#{@user.send(field.to_sym)}"}
end

Then /^(?:|I )should see #"([^\"]*)"$/ do |var_str|
  Then %Q{I should see "#{process(var_str)}"}
end