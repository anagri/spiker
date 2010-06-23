class User < ActiveRecord::Base
  # authorization
  using_access_control

  # acts_as
  enhanced_acts_as_authentic

  # relationships
  belongs_to :office

  # validations
  validates_presence_of :office
  validates_inclusion_of :role, :in => Role.roles

  def role_symbols
    [role.to_sym]
  end

  def deliver_password_reset_instructions!(opts)
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(opts.merge(:email => email, :id => perishable_token))
  end
end