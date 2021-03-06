@MO
Feature: manage office
  In order to have application more useful
  as a admin/manager I want to create office under me
  so that I can use the application correctly

  Background:
    Given application is setup
    And net connections are enabled
    And office type exists and assigned to "@head_office_type"
    And office type exists and assigned to "@branch_office_type" with parent "@head_office_type" 
    And office exists and assigned to "@head_office"
    And a admin "testadmin" with password "testpass" exists
    And I login

  Scenario: create office
    Given I follow #"t view.offices.manage"
    And follow #"t view.offices.new"
    And fill in "office_name" with "branch office"
    And select #"e @head_office.name" from "office_parent_id"
    When I press #"t view.offices.create"
    Then I should see #"t offices.create.success"
    And  should see "branch office"
