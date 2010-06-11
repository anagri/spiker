Factory.define :session do |session|
  session.username do
    Factory.create(:user, :password => 'defaultpassword').username
  end
  session.password 'defaultpassword'
end

