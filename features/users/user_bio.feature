Feature: User bio
  As a site user
  In order to get to know other users better
  I would like to see a short bio of a user on his profile page

Background:
  Given the following users exist
    | first_name | last_name | email                   | bio                                        |
    | Alice      | Jones     | alicejones@hotmail.com  | Lives on a farm with many sheep and goats. |
    | Bob        | Butcher   | bobb112@hotmail.com     |                                            |

@jeff
Scenario: View user's bio details
  When I visit Alice's profile page
  Then I should see "Bio"
  And I should see "Lives on a farm with many sheep and goats."

@jeff
Scenario: User does not have a bio.
  When I visit Bob's profile page
  Then I should see "No Bio"

@jeff2 @javascript
Scenario: Add bio content to profile
  Given I am logged in
  And I am on "profile" page for user "me"
  And I click the "Edit" button
  And I fill in "Bio" with "Lives in the city"
  And I click "Update"
  Then I should see "Lives in the city"
  
