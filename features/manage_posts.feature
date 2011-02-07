Feature: Manage posts
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new post
    Given I am logged in as the admin
    And I am on the new post page
    When I fill in "Title" with "title 1"
    And I fill in "Content" with "content 1"
    And I press "Create"
    Then I should see "title 1"
    And I should see "content 1"

  Scenario: Delete post
    Given I am logged in as the admin
    And the following posts:
      |title|content|
      |title 1|content 1|
      |title 2|content 2|
      |title 3|content 3|
      |title 4|content 4|
    When I delete the 3rd post
    Then I should see the following posts:
      |Title|Content|
      |title 1|content 1|
      |title 2|content 2|
      |title 4|content 4|
