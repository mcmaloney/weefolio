Feature: Global Navigation
  As a user
  I want to click on links
  In order to go places on this site.
  
  @nav
  Scenario Outline: User follows all global nav links
    Given I am on the home page
    And I follow "<link>"
    Then I should be on the "<page>"
    
    Examples:
      | link      | page           |
      | contact   | contact page   |
      | directory | directory page |
      | help      | help page      |
    