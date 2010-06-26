def current_user
  @current_user ||= staff
end

def user_session(user, session_stubs = {})
  @session ||= stub('session', {:user => user}.merge(session_stubs))
end

def login(user, session_stubs = {})
  @current_user = user
  @session = nil
  Session.stubs(:find).returns(user_session(@current_user, session_stubs))
  @current_user
end

def logout
  @current_user = nil
  @session = nil
  Session.stubs(:find).returns(user_session(nil))
end

def guest
  nil
end

def staff(new = false)
  return @staff ||= make_user(:staff) if !new
  @staff = make_user(:staff)
end

def admin(new = false)
  return @admin ||= make_user(:admin) if !new
  @admin = make_user(:admin)
end

private
def make_user(role)
  user = stub_model(User, :role_symbols => [role])
  User.stubs(:find).with(user.id.to_s).returns(user)
  user
end


