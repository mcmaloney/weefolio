Feature: My Weefolio
  As a user
  I want to show my work off in a styled Weefolio
  So that people will think I am awesome
  
  Scenario: View Weefolio
    Given I am logged in as "mcmaloney"
    And I am on the home page
    When I follow "My Weefolio"
    Then I should be on the page for my weefolio
    