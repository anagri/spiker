@MO
Feature: manage office
  In order to have application more useful
  as a admin/manager I want to create office under me
  so that I can use the application correctly

  Background:
    Given net connections are enabled
    And office type exists and assigned to "@head_office_type"
    And office type exists and assigned to "@branch_office_type" with parent "@head_office_type" 
    And office exists and assigned to "@head_office"
    And a admin "testadmin" with password "testpass" exists
    And I login

  @current
  Scenario: create office
    Given I follow #"t dashboard.index.offices"
    And follow #"t offices.index.new"
    And fill in "office_name" with "branch office"
    And select #"e @head_office.name" from "office_parent_id"
    And select #"e @branch_office_type.name" from "office_office_type_id"
    When I press #"t offices.new.submit"
    Then I should see #"t offices.create.success"
    And  should see "branch office"
