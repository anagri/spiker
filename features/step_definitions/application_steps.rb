When /^(?:|I )visit the "([^"]*)" page for (\d+)$/ do |resource, id|
  visit send("#{resource}_path".to_sym, id)
end

Then /^(?:|I )should see msg "([^\"]*)"$/ do |msg_key|
  steps %Q{
    Then should see "#{t(msg_key)}" 
  }
end

When /^(?:|I )login$/ do
  steps %Q{
    When  I go to the login page
    And   fill in "session_username" with "#{@user.username}"
    And   fill in "session_password" with "#{@user.password}"
    And   press "Submit"
  }
end

When /^(?:|I )login with username "([^\"]*)" and password "([^\"]*)"$/ do |username, password|
  steps %Q{
    When  I go to the login page
    And   fill in "session_username" with "#{username}"
    And   fill in "session_password" with "#{password}"
    And   press "Submit"
  }
end

When /^password reset for "([^\"]*)" with expire "([^\"]*)" exists$/ do |username, time_to_expire|
  pending
end

When /^(?:|I )follow password reset$/ do
  pending
end

When /^(?:|I )login with username "([^\"]*)" and password "([^\"]*)" for "([^\"]*\d)" times$/ do |username, password, attempts|
  attempts.to_i.times do
    steps %Q{
      Then login with username "#{username}" and password "#{password}"
    }
  end
end

When /^password reset for "([^\"]*)" with expire "([^\"]*)" with used "([^\"]*)" exists$/ do |username, expires_in, link_used|
  pending
end

When /^(?:|I )follow non\-existent password reset link$/ do
  pending
end

When /^branch office "([^\"]*)" exists$/ do |office|
  pending
end

When /^(?:|I )visit the "users" page for user "([^\"]*)"$/ do |username|
  user = User.find_by_username(username)
  steps %Q{
    Then I visit the "users" page for #{user.id} 
  }
end