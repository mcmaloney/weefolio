Feature: Portfolio
  As a user
  I want to add work to my portfolio
  So that I can show off my stuff.
  
  Scenario: Show my portfolio (with nothing in it)
    Given I am logged in as "mcmaloney"
    And I am on the home page
    When I follow "Portfolio"
    Then I should be on my portfolio page
    And I should see "mcmaloney's Weefolio"
    
  Scenario: User adds a piece
    Given I am logged in as "mcmaloney"
    And I am on my portfolio page
    And I follow "Add Work"
    And I add a piece called "Marzipan Statue of Hitler"
    Then I should be on my portfolio page
    And I should see "Added 'Marzipan Statue of Hitler' to your Weefolio"
    And I should see "Marzipan Statue of Hitler"
    And I should see "This is going to be bad."
    