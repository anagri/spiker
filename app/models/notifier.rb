class Notifier < ActionMailer::Base
  def password_reset_instructions(opts)
    subject t("password_resets.email.subject")
    from t("password_resets.email.from")
    recipients opts.delete(:email)
    sent_on Time.now
    body :password_reset_link => edit_password_reset_url(opts)
  end

  def t(key, options = {})
    I18n.t(key, options)
  end
end