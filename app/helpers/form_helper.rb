module FormHelper
  def disabled(record)
    record.new_record? ? {} : {:disabled => 'disabled'}
  end
end