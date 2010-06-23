@UAS
Feature: logout
  In order to secure application
  as a user I should be able to logout
  so that no authorized action can be performed using my login

  Background:
    And a user "testuser" with password "testpass" exists
    And I login

  Scenario:logout a logged in user
    Given I am on the root page
    When I logout
    Then I should see #"t sessions.destroy.success"
    And should see #"t layout.login"
    And should be on the root page

  Scenario: logged out user should not be able to view profile
    Given I am on the root page
    And I logout
    And visit the "user" page for "e @user.id"
    Then I should see #"t users.show.unauthorized"

  @wip
  Scenario: session expired
    Given authenticated session has expired
    When I follow "Dashboard"
    Then I should be on the root page
    And  I should see #"t session.expired"

  @wip
  Scenario: user deactivated
    Given user have been deactivated
    When I follow "Dashboard"
    Then I should be on the root page
    And I should see #"t user.inactive"
  