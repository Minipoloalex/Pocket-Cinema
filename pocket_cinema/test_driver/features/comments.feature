Feature: Commenting on media and reading comments
  As a user
  I want to be able to comment on media
  so that I can share my opinion and read other people's opinions

  Scenario: Commenting on a movie and reading the comment
    Given I am not authenticated
    And I authenticate as "myUsername" with password "myPassword"
    Then I am on the "HomePage" page

    # Finding the movie
    Given I am on the "HomePage" page
    When I tap the "searchNavigationButton" button
    Then I am on the "SearchPage" page
    When I fill the "searchField" field without scrolling with "matrix"
    Then I am on the "SearchResultsPage" page
    And I expect the text "The Matrix" to be present
    And I expect the text "The Matrix Resurrections" to be present

    # Commenting on the movie
    When I tap the "The Matrix" element
    Then I am on the "MediaPage" page
    When I fill the "addCommentField" field without scrolling with "This is a comment"
    And I tap the "addCommentButton" button
    Then I expect the comment "myUsername" "This is a comment" "A moment ago" to be present

    # Going back to the search page
    When I tap the "backButton" button
    And I tap the "backButtonSearch" button
    Then I am on the "SearchPage" page

  Scenario: Reading comments from a movie
    Given I am not authenticated
    And I authenticate as "admin" with password "123456"
    Then I am on the "HomePage" page

    # Finding the movie
    Given I am on the "HomePage" page
    When I tap the "searchNavigationButton" button
    Then I am on the "SearchPage" page
    When I fill the "searchField" field without scrolling with "matrix"
    Then I am on the "SearchResultsPage" page
    And I expect the text "The Matrix" to be present
    And I expect the text "The Matrix Resurrections" to be present

    # Reading the comment
    When I tap the "The Matrix" element
    Then I am on the "MediaPage" page
    And I expect the comment "myUsername" "This is a comment" "A moment ago" to be present

    # Going back to the search page
    When I tap the "backButton" button
    And I tap the "backButtonSearch" button
    Then I am on the "SearchPage" page
