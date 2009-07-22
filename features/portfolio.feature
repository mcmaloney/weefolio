## I NEED TO BE REFACTORED!!

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
    And I have no pieces in my portfolio
    And I am on my portfolio page
    And I follow "Add Work"
    And I add a piece called "Marzipan Statue of Hitler"
    Then I should be on my portfolio page
    And I should see "Added 'Marzipan Statue of Hitler' to your Weefolio"
    And I should see "Marzipan Statue of Hitler"
    And I should see "This is going to be bad."
   
  Scenario: User visits edit page for a piece in his portfolio
    Given I am logged in as "mcmaloney"
    And I have a piece in my portfolio called "Moody Photo"
    And I am on my portfolio page
    When I follow "Edit"
    Then I should be on the edit piece page for "Moody Photo"
  
  Scenario: User edits a piece in his portfolio
    Given I am logged in as "mcmaloney"
    And I have a piece in my portfolio called "Moody Photo"
    And I am on the edit piece page for "Moody Photo"
    And I change the info to "Arty Photo" and "Yeah. That's better."
    Then I should be on my portfolio page
    And I should see "Piece updated."
    And I should see "Arty Photo"
  
  @tits
  Scenario: User deletes a piece in his profile
    Given I am logged in as "mcmaloney"
    And I have a piece in my portfolio called "Moody Photo"
    And I am on my portfolio page
    When I follow "Delete"
    Then I should see "'Moody Photo' deleted."
    And I should have no pieces in my portfolio
  
  @skip
  Scenario: Tier 1 user adds max (5) pieces
    Given I am logged in as "mcmaloney"
    And my account tier is 1
    And I have 5 pieces in my portfolio
    And I am on my portfolio page
    When I follow "Add Work"
    Then I should see "You have uploaded the maximum amount of pieces for your account type."
  
  @skip
  Scenario: Tier 2 user adds max (15) pieces
    Given I am logged in as "mcmaloney"
    And I have 15 pieces in my portfolio
    And I am on my portfolio page
    When I follow "Add Work"
    Then I should see "You have uploaded the maximum amount of pieces for your account type."
  
  @skip
  Scenario: Tier 3 user adds max (25) pieces
    Given I am logged in as "mcmaloney"
    And I have 25 pieces in my portfolio
    And I am on my portfolio page
    When I follow "Add Work"
    Then I should see "You have uploaded the maximum amount of pieces for your account type."
  
  

    