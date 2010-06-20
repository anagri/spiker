@UA
Feature: login
  In order to use application
  as a user I have to authenticate
  so that I can do authorized actions

  Scenario: valid login
    Given a user "testuser" with password "testpass" exists
    When I login
    Then I should be on the root page
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
    And  should see "Username cannot be blank"

  Scenario: password not provided
    When I login with username "testuser" and password ""
    Then I should be on the login page
    And  should see "Password cannot be blank"

  Scenario: password is wrong
    Given a user "testuser" with password "testpass" exists
    When I login with username "testuser" and password "wrong"
    Then I should be on the login page
    And  should see "Password is not valid"

  @wip
  Scenario: recurrent invalid login attempts
    Given a user "testuser" with password "testpass" exists
    When I login with username "testuser" and password "wrong" for "5" times
    Then I should see msg "sessions.create.locked"

  @wip
  Scenario: password reset request
    Given a user "testuser" with password "testpass" exists
    When I go to the password reset page
    And  fill in "password_reset_username" with "testuser"
    And  press "Submit"
    Then I should see msg "password_reset.create.success"

  @wip
  Scenario: password reset expired
    Given a user "testuser" with password "testpass" exists
    And  password reset for "testuser" with expire "1.days.ago" exists
    When I follow password reset
    Then I should see msg "password_reset.expired"

  @wip
  Scenario: password reset link exhausted
    Given a user "testuser" with password "testpass" exists
    And  password reset for "testuser" with expire "1.days.since" with used "true" exists
    When I follow password reset
    Then I should see msg "password_reset.invalid"

  @wip
  Scenario: password reset link invalid
    Given a user "testuser" with password "testpass" exists
    When I follow non-existent password reset link
    Then I should see msg "password_reset.invalid"

  @wip
  Scenario: password reset while logged in
    Given a user "testuser" with password "testpass" exists
    And  password reset for "testuser" with expire "1.days.since" exists
    And  I login
    When I follow password reset
    Then I should see msg "password_reset.logged_in"

