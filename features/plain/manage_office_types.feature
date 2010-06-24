@MOT
Feature: manage office types
  In order to have application more useful
  as a admin/manager I want to create office types
  so that I can use the application correctly

  Background:
    Given office type exists and assigned to "@head_office_type"
    And office type exists and assigned to "@sub_head_office_type"

  Scenario: admin should be able to see add/edit office types
    Given a admin "admintest" with password "testpass" exists
    And login
    And follow #"t dashboard.index.office_types"
    Then I should be on the office types page
    And should see #"e @head_office_type.name"
    And should see #"e @sub_head_office_type.name"
    And should see #"t view.office_types.new"

  Scenario: admin should be able to add office type
    Given a admin "admintest" with password "testpass" exists
    And login
    And follow #"t dashboard.index.office_types"
    And I should be on the office types page
    And fill in "office_type_name" with "new office type"
    And press #"t view.office_types.create"
    Then I should see #"t office_types.create.success"
    And I should see "new office type"

  Scenario: non-admin should not be able to edit office type

