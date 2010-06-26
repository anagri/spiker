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
When /^(?:|I )press #"([^\"]*)"$/ do |var_str|
  Then %Q{I press "#{process(var_str)}"}
end

# access i18n links
When /^(?:|I )follow #"([^\"]*)"(?: within #"([^\"]*)")?$/ do |var_str, field_str|
  if field_str
    Then %Q{I follow "#{process(var_str)}" within "#{process(field_str)}"}
  else
    Then %Q{I follow "#{process(var_str)}"}
  end
end

When /^(?:|I )fill in "([^\"]*)" with current user$/ do |field|
  Then %Q{I fill in "#{field}" with "#{@user.send(field.to_sym)}"}
end

Then /^(?:|I )should see #"([^\"]*)"$/ do |var_str|
  Then %Q{I should see "#{process(var_str)}"}
end

Then /^I should be on\# "([^\"]*)"$/ do |var_str|
  URI.parse(current_url).path.should == process(var_str)
end