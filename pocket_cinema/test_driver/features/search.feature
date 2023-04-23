Feature: Searching for movies/series by title
  As a user,
  I want to be able to search for movies/series by its name
  So that I can get information about it and add it to my personal lists
  # Adding to lists not implemented yet

  Scenario: Getting to the search page
    Given I am not authenticated
    And I authenticate as "myUsername" with password "myPassword"
    And I am on the "HomePage" page
    When I tap the "searchNavigationButton" button
    Then I am on the "SearchPage" page

  Scenario: Searching for a movie by title
    Given I am on the "SearchPage" page
    When I fill the "searchField" field with "matrix"
    Then I expect the text "The Matrix" to be present
    And I expect the text "The Matrix Resurrections" to be present

  # Scenario: Changing to series
  #  Given I am on the "SearchPage" page
  #  When I tap the "seriesTab" button
  #  Then I am on the

  Scenario: Going back to the home page
    Given I am on the "SearchPage" page
    When I tap the "newsNavigationButton" button
    Then I am on the "HomePage" page
