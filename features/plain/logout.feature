Feature: logout
  In order to secure application
  users should be able to logout

  Background:

  Scenario:logout an logged in user
    Given a user "testuser" with password "testpass" exists
    And   is logged in application
    And   am on the root page
    When  follow "Logout"
    Then  I should be on the root page
    And   should see "Login"
    And   should see "Successfully logged out"

