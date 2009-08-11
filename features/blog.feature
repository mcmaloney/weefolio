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
      | New Post |
      | A Post   |
    And I am on the home page
    And I follow "Blog"
    Then I should be on the blog page
    And I should see "New Post"
    And I should see "A Post"
  
  @blog
  Scenario: User views post
    Given I am logged in as "mcmaloney"
    And there is a blog post called "Pictures of Cats Outlawed"
    And I am on the blog page
    When I follow "Pictures of Cats Outlawed"
    Then I should be on the post page for "Pictures of Cats Outlawed"
    And I should see "Pictures of Cats Outlawed"
    And I should see "Because they are horrible creatures."
    