Feature: Navigation
  I WANT TO GO TO THERE
  
  Scenario Outline: Logged out nav
    When I go to path "/<key>"
    Then I should see the page
    
    Examples:
      | key         |
      | directory   |
      | signup      |
      | help        |
      | login       |
      | docs/themes |
  
    

      