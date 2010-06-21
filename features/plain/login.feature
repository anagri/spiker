@UA
Feature: login
  In order to use application
  as a user I have to authenticate
  so that I can do authorized actions

  Scenario: valid login
    Given a user "testuser" with password "testpass" exists
    When I login
    Then I should be on the root page
  # TODO use i18n msg
    And  should see "Logout"
    And  should see msg "sessions.create.success"

  Scenario: login using unexisting username
    Given a user "testuser" does not exists
    When I login with username "testuser" and password "testpass"
    Then I should be on the login page
    And  should see msg "sessions.create.username.missing"

  Scenario: username not provided
    When I login with username "" and password "testpass"
    Then I should be on the login page
  # TODO use i18n msg
    And  should see "Username cannot be blank"

  Scenario: password not provided
    When I login with username "testuser" and password ""
    Then I should be on the login page
  # TODO use i18n msg
    And  should see "Password cannot be blank"

  Scenario: password is wrong
    Given a user "testuser" with password "testpass" exists
    When I login with username "testuser" and password "wrong"
    Then I should be on the login page
  # TODO use i18n msg
    And  should see "Password is not valid"

  Scenario: recurrent invalid login attempts
    Given a user "testuser" with password "testpass" exists
    When I login with username "testuser" and password "wrong" for "6" times
  # TODO use i18n msg
    Then I should see "Consecutive failed logins limit exceeded, account has been temporarily disabled."

  Scenario: password reset with email
    Given a user "testuser" with password "testpass" exists
    When I go to the new password reset page
    And  fill in "email" with current user
    And  press t "password_resets.new.submit"
    Then I should see msg "password_resets.create.success"

  @manual @wip
  Scenario: password reset expired
    Given a user "testuser" with password "testpass" exists
    And  password reset with expire "5.days.ago" for "testuser" exists
    When I follow password reset for "testuser"
    Then I should see msg "password_reset.expired"

  Scenario: password reset link invalid if user logs in
    Given a user "testuser" with password "testpass" exists
    And  request password reset
    And I login
    And I logout  
    When I jump to password reset
    Then I should see msg "password_resets.edit.error"

  Scenario: password reset link invalid
    Given a user "testuser" with password "testpass" exists
    When I follow non-existent password reset link
    Then I should see msg "password_resets.edit.error"

  Scenario: password reset while logged in
    Given a user "testuser" with password "testpass" exists
    And  I login
    And  request password reset
    When I jump to password reset
    Then I should see msg "password_resets.edit.unauthorized"

