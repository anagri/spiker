class User < ActiveRecord::Base
  enhanced_enum_attr :role, %w(admin manager staff loan_officer client maintenance none), :init => :none, :nil => false
  enhanced_acts_as_authentic
  using_access_control

  belongs_to :office
  validates_presence_of :office

  def role_symbols
    [role.to_sym]
  end

  def deliver_password_reset_instructions!(opts)
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(opts.merge(:email => email, :id => perishable_token))
  end
end