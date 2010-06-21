When /^(?:|I )request password reset$/ do
  @reset_url = edit_password_reset_path(@user.reload.perishable_token)
end

When /^(?:|I )follow non\-existent password reset link$/ do
  visit edit_password_reset_url("boomdoesnotexists")
end

When /^(?:|I )jump to password reset$/ do
  visit @reset_url
end