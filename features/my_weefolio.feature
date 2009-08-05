Feature: My Weefolio
  As a user
  I want to show my work off in a styled Weefolio
  So that people will think I am awesome
  
  Scenario: View Weefolio
    Given I am logged in as "mcmaloney"
    And I am on the home page
    When I follow "My Weefolio"
    Then I should be on the page for my weefolio
  
  Scenario: View Weefolio in Grid mode
    Given I am logged in as "mcmaloney"
    And my layout type is 1
    And I am on the home page
    When I follow "My Weefolio"
    Then I should be on the page for my weefolio
    And its layout type should be "grid"
  
  Scenario: View Weefolio in List mode
    Given I am logged in as "mcmaloney"
    And my layout type is 2
    And I am on the home page
    When I follow "My Weefolio"
    Then I should be on the page for my weefolio
    And its layout type should be "list"
    