Feature: User
  I want to sign up for a Weefolio account
  So that I can show off my work in a portfolio
  
  Scenario: User visits sign up page
    Given I am on the home page
    And I follow "Sign Up"
    Then I should be on the sign up page
  
  Scenario: User signs up
    Given I am on the sign up page
    And there are no users 
    When I sign up as "mcmaloney"
    Then I should be on the home page
    And I should see "Welcome to Weefolio, mcmaloney!"
    And I should have 1 user
    And I should have 1 portfolio
    And I should see "Log Out"
    And I should not see "Log In"
    And I should not see "Sign Up"