Feature: Mailer
  We have several mailers for different uses, listed below.
  
  # CONTACT WEEFOLIO USER
  As a weefolio viewer
  I want to fill in a contact form on the weefolio I'm looking at
  So that I can contact the owner of that weefolio.
  
  # CONTACT WEEFOLIO
  As a weefolio user
  I want to contact the weefolio staff
  In order to deliver praise or gripes
  
  @mailer
   Scenario: Viewer fills out contact form
     Given I am logged in as "mcmaloney"
     And I am on the page for my weefolio
     And I send myself a message
     Then I should see "Message sent."
  
  @mailer 
  Scenario: User contacts weefolio staff
    Given I am logged in as "mcmaloney"
    And I am on the contact page
    And I send weefolio a message of praise and admiration
    Then I should see "Thanks for sending us a note. We'll get back to you as soon as possible."
  
    