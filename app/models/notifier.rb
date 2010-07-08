class Notifier < ActionMailer::Base
  include I18nSupport

  def password_reset_instructions(opts)
    subject t("notifier.password_reset_instructions.subject")
    from t("notifier.password_reset_instructions.from")
    recipients opts.delete(:email)
    sent_on Time.now
    body :password_reset_link => edit_password_reset_url(opts)
  end
end