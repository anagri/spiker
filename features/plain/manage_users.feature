@MU
Feature: manage users
  In order to have application be useful to all users
  as an admin I want to create and assign users properties
  so that users can use application

  Background:
    Given a admin "admin" with password "secret" exists
    And branch office "branch office" exists
    And I login

  @wip
  Scenario: create users
    Given I am on the new user page
    And fill in "user_username" with "newuser"
    And fill in "user_password" with "newpass"
    And fill in "user_password_confirmation" with "newpass"
    And select "staff" from "user_roles"
    And select "branch office" from "offices"
    And check "active"
    And press "Submit"
    Then I should see msg "users.created"

  @wip
  Scenario: update password for user
    Given a user "staff" with password "secret" exists
    And I am "admin"
    And I am on the users page
    And visit the "users" page for user "staff"
    When fill in "user_password" with "newsecret"
    And fill in "user_password_confirmation" with "newsecret"
    And press "Submit"
    Then I should see msg "users.update.password"

  @wip
  Scenario: deactivate user
    Given a user "staff" with password "secret" exists
    And I am "admin"
    And I am on the users page
    And visit the "users" page for user "staff"
    When uncheck "active"
    And press "Submit"
    Then I should see msg "users.update.deactivated"

