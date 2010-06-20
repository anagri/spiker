@UAS
Feature: logout
  In order to secure application
  as a user I should be able to logout
  so that no authorized action can be performed using my login

  Background:
    Given a user "testuser" with password "testpass" exists
    And I login

  Scenario:logout a logged in user
    Given I am on the root page
    When I follow "Logout"
    Then I should see "Successfully logged out"
    And should see "Login"
    And should be on the root page

  Scenario: logged out user should not be able to view profile
    Given I am on the root page
    And follow "Logout"
    And visit the "user" page for 1
    Then I should see "You are not allowed to perform this action"

  @wip
  Scenario: session expired
    Given authenticated session has expired
    When I follow "Dashboard"
    Then I should be on the root page
    And  I should see msg "session.expired"

  @wip
  Scenario: user deactivated
    Given user have been deactivated
    When I follow "Dashboard"
    Then I should be on the root page
    And I should see msg "user.inactive"
  