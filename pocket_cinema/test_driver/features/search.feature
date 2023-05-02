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

  Scenario: Searching for an existing movie by title
    Given I am on the "SearchPage" page
    When I fill the "searchField" field without scrolling with "matrix"
    Then I am on the "SearchResultsPage" page
    And I expect the text "The Matrix" to be present
    And I expect the text "The Matrix Resurrections" to be present

  Scenario: Clicking searched movie
    Given I am on the "SearchResultsPage" page
    When I fill the "searchField" field without scrolling with "mario"
    And I tap the "The Super Mario Bros. Movie" movie
    Then I am on the "MediaPage" page

  Scenario: Clicking to go back on movie page
    Given I am on the "MediaPage" page
    When I tap the "backButton" button
    Then I am on the "SearchResultsPage" page

  Scenario: Searching for a non-existing movie
    Given I am on the "SearchResultsPage" page
    When I fill the "searchField" field without scrolling with "qwertyuiop"
    Then I find no results on the movies tab

  Scenario: Searching for an existing series by title
    Given I am on the "SearchResultsPage" page
    And I tap the "seriesTab" button without scrolling it into view
    And I fill the "searchField" field without scrolling with "mad"
    Then I expect the text "Mad Men" to be present

  Scenario: Searching for a non-existent series
    Given I am on the "SearchResultsPage" page
    When I tap the "seriesTab" button without scrolling it into view
    And I fill the "searchField" field without scrolling with "qwertyuiopasdfghjklzxcvbnm"
    Then I find no results on the series tab

  Scenario: Going back to the initial search page
    Given I am on the "SearchResultsPage" page
    When I tap the "backButtonSearch" button
    Then I am on the "SearchPage" page

  Scenario: Going back to the home page
    Given I am on the "SearchPage" page
    When I tap the "newsNavigationButton" button
    Then I am on the "HomePage" page
