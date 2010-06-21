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

When /^password reset with expire "([^\"]*)"(?:| for "([^\"]*)") exists$/ do |time_to_expire, username|
  user = username.nil? ? @user : User.find_by_username(username)
  user.without_access_control_do_update_attributes!(:perishable_token => user.perishable_token, :updated_at => time_to_expire.convert_to_time)
end

When /^(?:|I )follow password reset(?:| for "([^\"]*))"$/ do |username|
  user = username.nil? ? @user : User.find_by_username(username)
  Then "I go to the edit password reset page with params \"id\" \"#{user.perishable_token}\""
end

When /^(?:|I )login with username "([^\"]*)" and password "([^\"]*)" for "([^\"]*\d)" times$/ do |username, password, attempts|
  attempts.to_i.times do
    steps %Q{
      Then login with username "#{username}" and password "#{password}"
    }
  end
end

When /^(?:|I )request password reset$/ do
  @reset_url = edit_password_reset_path(@user.reload.perishable_token)
end

When /^(?:|I )follow non\-existent password reset link$/ do
  visit edit_password_reset_url("boomdoesnotexists")
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

Then /^(?:|I )go to the ([^\"]*) page with params "([^\"]*)" "([^\"]*)"$/ do |page, id, value|
  visit self.send((page.gsub(/\s/, "_") << "_url").to_sym, id.to_sym => value)
end

When /^(?:|I )press t "([^\"]*)"$/ do |key|
  Then %Q{I press "#{t(key)}"}
end

When /^(?:|I )fill in "([^\"]*)" with current user$/ do |field|
  Then %Q{I fill in "#{field}" with "#{@user.send(field.to_sym)}"}
end

When /^(?:|I )logout$/ do
  Then %Q{I follow "Logout"}
end

When /^(?:|I )jump to password reset$/ do
  visit @reset_url
end