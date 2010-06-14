def current_user
  @current_user ||= staff
end

def user_session(user, session_stubs = {})
  @session ||= stub('session', {:user => user}.merge(session_stubs))
end

def login(user, session_stubs = {})
  @current_user = user
  @session = nil
  Session.stubs(:find).returns(user_session(user, session_stubs))
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
  return @staff ||= make_staff if !new
  @staff = nil and @staff ||= make_staff
end

private
def make_staff
  staff = stub_model(User, :role_symbols => [:staff])
  User.stubs(:find).with(staff.id.to_s).returns(staff)
  staff
end


