Feature: login
  In order to use application
  as a user I have to authenticate
  so that I can do authorized actions

  Scenario: login as existing user
    Given a user "testuser" with password "testpass" exists
    When  I go to the login page
    And   fill in "session_username" with "testuser"
    And   fill in "session_password" with "testpass"
    And   press "Submit"
    Then  I should be on the root page
    And   should see "Logout"
    And   should see "Edit Profile"

  Scenario: login as unregistered user
    Given a user "testuser" does not exists
    When  I go to the login page
    And   fill in "session_username" with "testuser"
    And   fill in "session_password" with "testpass"
    And   press "Submit"
    Then  I should be on the login page
    And   should see "Error while doing registration"


