class PasswordReset < ActiveRecord::Base
  def self.columns() @columns ||= []; end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  column :email

  validates_presence_of :email
  validates_format_of :email, :with => Constants::EMAIL_REGEX, :if => Proc.new {|password_reset| password_reset.email.present? }
  validate :user_with_email_exists

  def user
    User.find_by_email(email)
  end

  protected
  def user_with_email_exists
    errors.add(:email, :email_missing) if email.present? && Constants::EMAIL_REGEX.match(email) && user.nil?
  end
end