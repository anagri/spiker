Given /^a user "([^"]*)" with password "([^"]*)" exists$/ do |username, password|
  @user = Factory.without_access_control_do_create(:user, :username => username, :password => password)
end

Given /^a user "([^\"]*)" does not exists$/ do |username|
  fail if User.exists?(:username => username)
end
