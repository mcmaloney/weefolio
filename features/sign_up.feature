Feature: Sign Up
  I WANNA MAKE A ACCOUNT SO I CAN USE THIS SHIT
  
  Scenario: User signs up with good info
    Given there are no users
    And there are no objects associated with users
    And I am on the sign up page
    And I sign up with "mcmaloney", "michael@fancylabs.com", "giraffe"
    Then I should have a portfolio
    And I should have a design
    And I should have a plan
    And there should be 1 user
    And there should be 1 plan
    And there should be 1 portfolio
    And there should be 1 design
  
    
