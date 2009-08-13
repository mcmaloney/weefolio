Feature: Mailer
  We have several mailers for different uses. 
  
  # CONTACT WEEFOLIO USER
  As a weefolio viewer
  I want to fill in a contact form on the weefolio I'm looking at
  So that I can contact the owner of that weefolio.
  
  # CONTACT WEEFOLIO
  As a weefolio user
  I want to contact the weefolio staff
  In order to deliver praise or gripes
  
  # GET YOUR PASSWORD
  As a weefolio user
  I want to get my password emailed to me when I forget it
  So that I can login again
  
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
  
  @this
  Scenario: User changes password
    Given I am on the login page
    And I have forgotten my password
    When I follow "forgot your password?"
    And I fill in the account details I do remember
    Then I should see "Password changed. You can now login as 'mcmaloney' with your new password."
  
  @this
  Scenario: User tries to change password but fails
    Given I am on the login page
    And I have forgotten my password
    And I fill in incorrect details
    Then I should see "Bad login/email."
    