@MO
Feature: manage office
  In order to have application more useful
  as a admin/manager I want to create office under me
  so that I can use the application correctly

  Background:
    Given a admin "testadmin" with password "testpass" exists
    And I login

  Scenario: create office
    Given I follow t "dashboard.index.offices"
    And follow t "offices.index.new"
    And fill in "office_name" with "branch office"
    And select "Head Office" from "office_parent_id"
    When I press t "offices.new.submit"
    Then  I should see msg "offices.create.success"
    And  should see "branch office"
    



