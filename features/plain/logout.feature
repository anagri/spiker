Feature: logout
  In order to secure application
  as a user I should be able to logout
  so that no authorized action can be performed using my login

  Background:
    Given a user "testuser" with password "testpass" exists
    And  is logged in application

  Scenario:logout an logged in user
    Given  am on the root page
    When I follow "Logout"
    Then I should see "Successfully logged out"
    And  should see "Login"
    And  should be on the root page

  Scenario: logged out user should not be able to view profile
    Given I am on the root page
    And follow "Logout"
    And visit the "user" page for 1
    Then I should see "You are not allowed to perform this action"

