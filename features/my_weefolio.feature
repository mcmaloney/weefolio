Feature: My Weefolio
  As a user
  I want to show my work off in a styled Weefolio
  So that people will think I am awesome
  
  Scenario: View Weefolio
    Given I am logged in as "mcmaloney"
    And I am on the home page
    When I follow "My Weefolio"
    Then I should be on the page for my weefolio
    And I should see "Hello! My name is mcmaloney and this is my Weefolio!"
    And I should see "About mcmaloney"
    And I should see "Contact mcmaloney"
    
  Scenario Outline: View in Grid/List modes
    Given I am logged in as "mcmaloney"
    And my layout type is <type>
    And I am on the home page
    When I follow "My Weefolio"
    Then I should be on the page for my weefolio
    And its layout type should be "<layout>"
    
    Examples:
    | type | layout |
    | 1    | grid   |
    | 2    | list   |
  
  @tits
  Scenario: View piece from grid thumbnail link
    Given I am logged in as "mcmaloney"
    And my layout type is 1
    And I have uploaded a piece called "cowphin" to my portfolio
    And I am on the page for my weefolio
    And I follow "cowphin"
    Then I should be on the piece page for "cowphin"
    And I should see "cowphin"
    