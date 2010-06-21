# login the current user
When /^(?:|I )login$/ do
  steps %Q{
    Then  I go to the login page
    And   fill in "session_username" with "#{@user.username}"
    And   fill in "session_password" with "#{@user.password}"
    And   press "Submit"
  }
end

# login with passed params
When /^(?:|I )login with username "([^\"]*)" and password "([^\"]*)"$/ do |username, password|
  steps %Q{
    When  I go to the login page
    And   fill in "session_username" with "#{username}"
    And   fill in "session_password" with "#{password}"
    And   press "Submit"
  }
end

When /^(?:|I )login with username "([^\"]*)" and password "([^\"]*)" for "([^\"]*\d)" times$/ do |username, password, attempts|
  attempts.to_i.times do
    Then %Q{login with username "#{username}" and password "#{password}"}
  end
end

When /^(?:|I )logout$/ do
  Then %Q{I follow "Logout"}
end

