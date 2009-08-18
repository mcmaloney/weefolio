Feature: Upgrade Account
  As a user
  I want to upgrade my account tier
  So that I can do more with weefolio
  
  @up
  Scenario Outline: User changes account tier from 1 to 2
    Given I am logged in as "mcmaloney"
    And my account tier is <start_tier>
    And I am on the account page for "mcmaloney"
    And I choose "<end_tier>"
    And I enter my credit card information in the given fields
    And I press "Save"
    Then I should see "<message>" 
    
    Examples:
      | start_tier | end_tier             | message                                                                         |
      | 1          | user_account_tier_2 | Thanks for upgrading your account! You now have access to all the Plus features |
      | 2          | user_account_tier_3 | Thanks for upgrading your account! You now have access to all the Pro features  |
  