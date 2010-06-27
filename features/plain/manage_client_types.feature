@MOT
Feature: manage client types
  In order to have application more useful
  as a admin/manager I want to create client types
  so that I can use the application correctly


  Background:
    Given a client type "group" exists and assigned to "@group"
    And a client type "center" exists with parent "@group" and assigned to "@center"
    And a client type "individual" exists with parents "@group,@center" and assigned to "@individual" 

  Scenario: admin should be able to see add/edit client types
    Given a admin "admintest" with password "testpass" exists
    And login
    And follow #"t view.client_types.manage"
    Then I should be on the client types page
    And should see #"e @group.name"
    And should see #"e '>' + @center.name"
    And should see #"e '>' + @individual.name"
    And should see #"e '>>' + @individual.name"
    And should see #"t view.client_types.new"


  Scenario: user should not be able to see add/edit client types
