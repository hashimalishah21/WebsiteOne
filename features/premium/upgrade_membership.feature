@stripe_javascript @javascript
Feature: Allow Users to Upgrade Membership
  As a site admin
  So that we can achieve financial stability
  I would like users to be able to upgrade their premium plans

  Background:
    Given the following plans exist
      | name         | id          | amount | free_trial_length_days |
      | Premium      | premium     | 1000   | 7                      |
      | Premium Mob  | premiummob  | 2500   | 0                      |
    And the following users exist
      | first_name | last_name | email                  | github_profile_url         | last_sign_in_ip |
      | Alice      | Jones     | alice@btinternet.co.uk | http://github.com/AliceSky | 127.0.0.1       |

  Scenario: User is on free tier and looking at own page
    Given I am logged in
    And I am on my profile page
    Then I should see "Basic Member"
    And I should not see "Premium Member"
    And I should not see "Premium Mob Member"

  Scenario: User is on free tier and looking at other persons profile page
    Given I am logged in
    And I visit Alice's profile page
    Then I should see "Basic Member"
    And I should not see "Premium Member"
    And I should not see "Premium Mob Member"
    And I should not see button "Upgrade to Premium"
    And I should not see button "Upgrade to Premium Mob"

  Scenario: User upgrades to premium from free tier
    Given I am logged in
    And I am on my profile page
    And I click "Upgrade to Premium"
    And I click "Subscribe" within the card_section
    When I fill in appropriate card details for premium
    Then I should see "Premium Member"
    Given I am on my profile page
    Then I should see "Premium Member"
    Then I should not see "Basic Member"
    Then I should not see "Premium Mob Member"
    And I should see button "Upgrade to Premium Mob"
    And I should see myself in the premium members list

  Scenario: User upgrades to premium mob from premium
    Given I am logged in as a premium user with name "John", email "john@john.com", with password "asdf1234"
    And I am on my profile page
    And I click "Upgrade to Premium Mob"
    Then I should see "Premium Mob Member"
    Given I am on my profile page
    Then I should see "Premium Mob Member"
    Then I should not see "Basic Member"
    And I should not see "Premium Member"
    And I should not see button "Upgrade to Premium"
    And I should not see button "Upgrade to Premium Mob"

  Scenario: User tries to upgrade to premium mob from premium but fails
    Given I am logged in as a premium user with name "John", email "john@john.com", with password "asdf1234"
    And I am on my profile page
    And there is a card error updating subscription
    And I click "Upgrade to Premium Mob"
    Then I should see "The card was declined"
    And I should not see "Premium Mob Member"
    Given I am on my profile page
    Then I should not see "Premium Mob Member"
    Then I should not see "Basic Member"
    And I should see "Premium Member"
    And I should see button "Upgrade to Premium Mob"
