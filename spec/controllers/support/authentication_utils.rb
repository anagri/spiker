def current_user
  @current_user ||= staff
end

def user_session(user = current_user, session_stubs = {})
  @session ||= stub('session', {:user => user}.merge(session_stubs))
end

def login(user = current_user, session_stubs = {})
  @current_user = user
  @session = nil
  Session.stubs(:find).returns(user_session(user, session_stubs))
  @current_user
end

def logout
  login(guest)
end

def guest
  stub('guest', :role_symbols => [:guest])
end

def staff
  user = stub_model(User, :role_symbols => [:staff])
  User.stubs(:find).with(user.id.to_s).returns(user)
  user
end


