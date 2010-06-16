Feature: login
  In order to use application
  users have to authenticate themselves
  so that only authorized actions are allowed to users

  Scenario: login as existing user
    Given a user "testuser" with password "testpass" exists
    When  I go to the new user_login page
    And   fill in "session_username" with "testuser"
    And   fill in "session_password" with "testpass"
    And   press "submit"
    Then  I should be on the root page
    And   should see "Logout"
    And   should see "Edit Profile"

  Scenario: login as unregistered user
    Given a user "testuser" does not exists
    When  I go to the new user_login page
    And   fill in "session_username" with "testuser"
    And   fill in "session_password" with "testpass"
    And   press "submit"
    Then  I should be on the login page
    And   should see "Error while doing registration"


