Feature: Admin
  As an admin user
  I want to be able to administrate the site with special privileges
  In order to maintain peace and prosperity
  
  @admin
  Scenario: Admin user logs in, views console
    Given I am an admin user
    And I login 
    And I am on the home page
    Then I should see "Admin Actions"
  
  @admin
  Scenario: Regular user logs in, should not see console
    Given I am logged in as "mcmaloney"
    And I am on the home page
    Then I should not see "Admin Actions"
  
  @admin 
  Scenario Outline: Admin Pages
    Given I am an admin user
    And the following users exist:
      | login    |
      | kjgomez  |
      | mgmcadam |
    And the following pieces exist:
      | title    |
      | Fred     |
      | Martha   |
    And the following posts exist:
      | title                            |
      | Seriously, enough with the cats. |
    And I login
    And I follow "<admin action>"
    Then I should be on the <page>
    And I should see "<thing I should see>"
    And I should see "<other thing I should see>"
    
    Examples:
      | admin action | page              | thing I should see               | other thing I should see |
      | Users        | users admin page  | kjgomez                          | mgmcadam                 |
      | Pieces       | pieces admin page | Fred                             | Martha                   |
      | Blog Console | blog page         | Seriously, enough with the cats. |                          |
      
  @admin
  Scenario Outline: Admin user does stuff to piece
    Given I am an admin user
    And I login
    And there is a piece called "Birth control montage"
    And I am on the pieces admin page
    When I follow "<action>"
    Then I should <primary result>
    And I should <secondary result>
    
    Examples:
    | action | primary result | secondary result                       |
    | Delete | have no pieces | see "'Birth control montage' deleted." |
    
    
    
    
    