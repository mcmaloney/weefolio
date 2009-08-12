Feature: Blog
  As a user
  I want to read posts on the Weefolio blog
  
  As an admin user
  I want to create and manage posts on the blog
  So that users can read them
  
  @blog
  Scenario: User visits blog page
    Given I am logged in as "mcmaloney"
    And the following blog posts exist:
      | title    |
      | My Post  |
      | A Post   |
    And I am on the home page
    And I follow "Blog"
    Then I should be on the blog page
    And I should see "My Post"
    And I should see "A Post"
    And I should not see "New Post"
    And I should not see "Edit"
    And I should not see "Delete"
  
  @blog
  Scenario: User views post
    Given I am logged in as "mcmaloney"
    And there is a blog post called "Pictures of Cats Outlawed"
    And I am on the blog page
    When I follow "Pictures of Cats Outlawed"
    Then I should be on the post page for "Pictures of Cats Outlawed"
    And I should see "Pictures of Cats Outlawed"
    And I should see "Because they are horrible creatures."
  
  @blog
  Scenario: Admin user creates new blog post
    Given I am an admin user
    And there are no blog posts
    And I login
    And I am on the blog page
    And I follow "New Post"
    And I create a post called "Stop With the Nudie Pictures"
    Then I should be on the blog page
    And I should see "Published 'Stop With the Nudie Pictures'"
    And I should have 1 post
    
  @blog
  Scenario: Admin user edits a post
    Given I am an admin user
    And I login
    And there is a blog post called "Reasons to be Pretty"
    And I am on the blog page
    When I follow "Edit"
    And I change the title of the post to "Wife for Sale"
    Then I should be on the post page for "Wife for Sale"
    And I should see "Post updated."
    
  @blog
  Scenario: Admin user deletes a post
    Given I am an admin user
    And I login
    And there is a post called "Wife for Sale"
    And I am on the blog page
    And I follow "Delete"
    Then I should see "'Wife for Sale' deleted."
    And there should be no posts
    
    
    