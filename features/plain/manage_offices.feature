@MO
Feature: manage office
  In order to have application more useful
  as a admin/manager I want to create office under me
  so that I can use the application correctly

  Background:
    Given application is setup
    And a office type exists and assigned to "@sub_head_office_type" with parent "@office_type"
    And a office type exists and assigned to "@branch_office_type" with parent "@sub_head_office_type"
    And a office exists and assigned to "@head_office"
    And a admin "testadmin" with password "testpass" exists
    And I login

  Scenario: show offices
    Given a office exists and assigned to "@sub_head_office" with parent "@head_office"
    And a office exists and assigned to "@branch_office" with parent "@sub_head_office" 
    When I follow #"t view.offices.manage"
    Then I should see #"e @head_office.name"
    And should see #"e @sub_head_office.name"
    And should see #"e @branch_office.name"



