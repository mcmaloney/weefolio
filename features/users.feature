## I NEED TO BE REFACTORED!!

Feature: User
  I want to sign up for a Weefolio account
  So that I can show off my work in a portfolio
  
  Scenario: User visits sign up page
    Given I am on the home page
    And I follow "Sign Up"
    Then I should be on the sign up page
  
  @this
  Scenario: User signs up
    Given I am on the sign up page
    And there are no users 
    When I sign up as "mcmaloney"
    Then I should be on the home page
    And I should see "Welcome to Weefolio, mcmaloney!"
    And I should have 1 user
    And I should have 1 portfolio
    And I should have 1 design
    And I should see the logged in nav bar in all its glory
    And I should not see "Login"
    And I should not see "Sign Up"
  
  Scenario: Existing user logs in
    Given I have already signed up as "kevingomez"
    And I am on the home page
    When I follow "Login"
    And I login as "kevingomez"
    Then I should be on the home page
    And I should see "Logged in as kevingomez"
    And I should see "Logout"
  
  Scenario: User visits account page
    Given I am logged in as "mcmaloney"
    And I am on the home page
    When I follow "Account"
    Then I should be on the account page for "mcmaloney"
  
  Scenario: User edits account info
    Given I am logged in as "mcmaloney"
    And I am on the account page for "mcmaloney"
    And I update my about me to say "I am one cool cat"
    And I update my tag line to say "See above."
    And I press "Save"
    Then I should see "Account info updated."
    
    
    