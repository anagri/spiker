module FormHelper
  def disabled(record)
    record.new_record? ? {} : {:disabled => 'disabled'}
  end

  def submit_caption(record)
    record.new_record? ? t('view.users.create') : t('view.users.update')
  end
end