Given /^a user "([^"]*)" with password "([^"]*)" exists$/ do |username, password|
  Factory.create(:user, :username => username, :password => password)
end
Given /^a user "([^\"]*)" does not exists$/ do |username|
  fail if User.exists?(:username => username)
end
