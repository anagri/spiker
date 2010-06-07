Factory.sequence(:username) {|n| "test_user_#{n}"}

Factory.define :user do |u|
  u.username {Factory.next(:username)}
  u.email {|u| "#{u.username}@testmail.com"}
  u.password 'dummypassword'
  u.password_confirmation {|u| u.password}
end

