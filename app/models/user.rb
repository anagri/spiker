class User < ActiveRecord::Base
  enhanced_enum_attr :role, %w(admin manager staff loan_officer client maintenance none), :init => :none, :nil => false

  acts_as_authentic
  using_access_control

  def role_symbols
    [role.to_sym]
  end
end