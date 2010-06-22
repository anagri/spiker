# verify the i18n message
Then /^(?:|I )should see msg "([^\"]*)"$/ do |msg_key|
  Then %Q{should see "#{t(msg_key)}"}
end

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
When /^(?:|I )follow t "([^\"]*)"$/ do |key|
  Then %Q{I follow "#{t(key)}"}
end

When /^(?:|I )fill in "([^\"]*)" with current user$/ do |field|
  Then %Q{I fill in "#{field}" with "#{@user.send(field.to_sym)}"}
end

