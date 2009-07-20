Feature: Portfolio
  As a user
  I want to add work to my portfolio
  So that I can show off my stuff.
  
  Scenario: Show my portfolio (with nothing in it)
    Given I am logged in as "mcmaloney"
    And I am on the home page
    When I follow "Portfolio"
    Then I should be on my portfolio page
    And I should see "Add Work"