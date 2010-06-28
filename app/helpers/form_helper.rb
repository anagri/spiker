module FormHelper
  def disabled(record)
    record.new_record? ? {} : {:disabled => 'disabled'}
  end

  def submit_caption(record)
    record.new_record? ? t("view.#{record.class.name.tableize}.create") : t("view.#{record.class.name.tableize}.update")
  end
end