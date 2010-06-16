class User < ActiveRecord::Base
  acts_as_authentic
  using_access_control

  def role_symbols
    [:staff]
  end
end