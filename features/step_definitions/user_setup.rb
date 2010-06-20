Given /^a user "([^"]*)" with password "([^"]*)" exists$/ do |username, password|
  @user = Factory.without_access_control_do_create(:user, :username => username, :password => password)
#  @user = Factory.without_access_control_do_create(:user, :username => username, :password => password, :role => "staff")
end

Given /^a user "([^\"]*)" does not exists$/ do |username|
  fail if User.exists?(:username => username)
end

Given /^authenticated session has expired$/ do
  pending
end

Given /^user have been deactivated$/ do
  pending
end

Given /^(?:|I )a admin "([^\"]*)" with password "([^\"]*)" exists$/ do |username, password|
  pending
#  @user = Factory.without_access_control_do_create(:user, :username => username, :password => password, :role => "admin")
end

Given /^(?:|I )am "([^\"]*)"$/ do |username|
  @user = User.find_by_username(username)
end