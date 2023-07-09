Feature: Create and maintain projects
  As a member of AgileVentures
  So that I can participate in AgileVentures activities
  I would like to add a new project

Background:
  Given I am on the home page

Scenario: Display list of projects
  When I follow "Our projects"
  Then I should see "List of projects"
  And I should see "Title"
  And I should see "Description"

Scenario Outline: List of projects table
  When I follow "Our projects"
  Then I should see a "List of Projects" table
  And I should see column <column>
  Examples:
  | column |
  |Title   |
  |Description|
  And I should see button <button>
  Examples:
  | button |
  |Show    |
  |Edit    |
  |Destroy |


