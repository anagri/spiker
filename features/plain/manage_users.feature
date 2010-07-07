@MU
Feature: manage users
  In order to have application be useful to all users
  as an admin I want to create and assign users properties
  so that users can use application

  Background:
    Given a admin "testadmin" with password "testpass" exists
    And office exists and assigned to "@branch_office"
    And I login

  Scenario: create users
    Given I am on the dashboard page
    And follow #"t view.users.manage"
    And follow #"t view.users.new"
    Then I should be on the new user page
    And fill in "user_username" with "newuser"
    And fill in "user_password" with "newpass"
    And fill in "user_password_confirmation" with "newpass"
    And fill in "user_email" with "testuser@email.com"
    And select #"e Role.role_name(Role::STAFF)" from "user_role"
    And select #"e @branch_office.name" from "user_office_id"
    And press #"t view.users.create"
    Then I should be on# "e user_path(User.find_by_username('newuser'))"
    And I should see #"t users.create.success"
    And should see #"newuser"
    And should see #"testuser@email.com"

  Scenario: update password for user
    Given a user "staff" with password "secret" exists and assigned to #"@testuser"
    And I am "admin"
    And I am on the dashboard page
    And follow #"t view.users.manage"
    And follow #"e @testuser.username << '(' << @testuser.email << ')'"
    And follow #"t view.common.edit"
    When fill in "user_password" with "newsecret"
    And fill in "user_password_confirmation" with "newsecret"
    And press #"t view.users.update"
    Then I should be on# "e user_path(@testuser)"
    And I should see #"t users.update.success"

  @wip
  Scenario: deactivate user
    Given a user "staff" with password "secret" exists
    And I am "admin"
    And I am on the users page
    And visit the "users" page for user "staff"
    When uncheck "active"                     m
    And press "Submit"
    Then I should see #"t users.update.deactivated"

