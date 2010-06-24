class User < ActiveRecord::Base
  # authorization
  using_access_control

  # acts_as
  acts_as_authentic

  # relationships
  belongs_to :office

  # validations
  validates_inclusion_of :role, :in => Role.roles

  validates_presence_of :office

  validate :office_for_role

  def role_symbols
    [role.to_sym]
  end

  def deliver_password_reset_instructions!(opts)
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(opts.merge(:email => email, :id => perishable_token))
  end

  protected
  def office_for_role
    errors.add(:office, :head_office_for_admin_role) if role && office && Role.admin_roles.include?(role.to_s) && office != Office.root
  end
end