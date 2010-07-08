module I18nSupport
  def t(key, options = {})
    I18n.t(key, options)
  end
end