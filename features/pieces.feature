Feature: Pieces
  As a user
  I want to create and manage the pieces that are in my Weefolio
  So that I can control what people see when they visit my page
  
  @tits
  Scenario: User lists piece for sale
    Given I am logged in as "mcmaloney"
    And I have no pieces in my portfolio
    And I am on my portfolio page
    And I follow "Add Work"
    And I add a piece that I want to sell called "Dead Hooker et Sienne"
    Then I should be on my portfolio page
    And I should see "Added 'Dead Hooker et Sienne' to your Weefolio (for sale at $150000.46)"
    And I should have 1 piece in my portfolio