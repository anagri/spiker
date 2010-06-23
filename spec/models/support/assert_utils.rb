def assert_invalid_record(record, errors)
  record.should be_invalid
  record.errors.should have_ar_errors(errors)
end
