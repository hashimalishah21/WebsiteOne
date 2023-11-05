Feature: As a site user
  In order to find a user with a relevant skill
  I would like to see a users self assessed skills set

  Background:
    Given I am on the "home" page
    And the following users exist
      | first_name | last_name | email                  | skill_list         |
      | Alice      | Jones     | alicejones@hotmail.com | ruby, rails, rspec |
      | Bob        | Butcher   | bobb112@hotmail.com    | ruby, c++          |
    And I am logged in as user with email "brett@example.com", with password "12345678"

  Scenario: Viewing skills
    Given I am on "profile" page for user "Alice"
    Then I should see:
      | title |
      | ruby  |
      | rails |
      | rspec |

  @javascript
  Scenario: Adding skills to profile
    Given I am on my "edit profile" page
    And I add skills "c++,java,php"
    And I click "Update" button
    And I go to my "profile" page
    And I click "Skills"
    And I should see:
      | title |
      | c++   |
      | java  |
      | php   |
