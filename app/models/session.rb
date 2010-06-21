class Session < Authlogic::Session::Base
  authenticate_with User
  consecutive_failed_logins_limit AppConfig.consecutive_failed_logins_limit
end