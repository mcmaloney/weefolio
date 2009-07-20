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
    And I should see "Portfolio | Account | Log Out"
    And I should not see "Log In"
    And I should not see "Sign Up"
  
  Scenario: Existing user logs in
    Given I have already signed up as "kevingomez"
    And I am on the home page
    When I follow "Log In"
    And I login as "kevingomez"
    Then I should be on the home page
    And I should see "Logged in as kevingomez"
    
  Scenario: User has not updated additional info
    Given I am logged in as "mcmaloney"
    And I have additional info that is blank
    And I am on the home page
    Then I should see "Update your info"
  
  Scenario: User visits account page
    Given I am logged in as "mcmaloney"
    And I am on the home page
    When I follow "Account"
    Then I should be on the account page for "mcmaloney"
    