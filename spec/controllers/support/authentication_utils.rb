def current_user(stubs = {})
  @current_user ||= stub_model(User, stubs)
end

def user_session(stubs = {}, user_stubs = {})
  @session ||= stub('session', {:user => current_user(user_stubs)}.merge(stubs))
end

def login(session_stubs = {}, user_stubs = {})
  Session.stubs(:find).returns(user_session(session_stubs, user_stubs))
end

def logout
  @session = nil
end

def login_user
  current_user = login(nil, {:first_name => 'oldfirstname', :last_name => 'oldlastname'}).user
  User.expects(:find).with(current_user.id.to_s).returns(current_user)
end

