Feature: Adding media to lists
  As a user,
  I want to be able to add media to my lists
  So that I can keep better track of media that I want to watch, have watched and others

  Background:
    Given I am not authenticated
    And I authenticate as "myUsername" with password "myPassword"
    And I am on the "HomePage" page
    When I tap the "searchNavigationButton" button
    Then I am on the "SearchPage" page

  Scenario: Adding a media to watched list
    Given I am on the "SearchPage" page
    When I fill the "searchField" field without scrolling with "titan"
    Then I am on the "SearchResultsPage" page
    And I expect the text "Titanic" to be present
    When I tap the "Titanic" widget
    Then I am on the "MediaPage" page
    When I tap the "Titanic CheckButton" button
    Then I wait until the "checkButton checked" is present

    When I tap the "backButton" button
    And I tap the "backButtonSearch" button
    Then I am on the "SearchPage" page
    And I tap the "my spaceNavigationButton" button
    Then I am on the "UserSpacePage" page

    When I tap the "watchedListButton" button
    Then I am on the "MediaListPage" page
    And I expect the text "Watched" to be present
    And I expect the text "Titanic" to be present
    And I restart the app
    # And I tap the back button (default back button)

  Scenario: Removing a movie from the watched list
    Given I am on the "SearchPage" page
    When I tap the "my spaceNavigationButton" button
    Then I am on the "UserSpacePage" page
    When I tap the "watchedListButton" button
    Then I am on the "MediaListPage" page
    And I expect the text "Watched" to be present
    And I expect the text "Titanic" to be present
    And I pause for 10 seconds
    When I tap the element that contains the text "Titanic"
    Then I am on the "MediaPage" page
    When I tap the "Titanic CheckButton" button
    Then I wait until the "checkButton unchecked" is present
    When I pause for 5 seconds

    When I tap the "backButton" button
    Then I am on the "MediaListPage" page
    And I expect the text "Watched" to be present
    And I expect the text "Titanic" to be absent

#  Scenario: Adding a media to "To Watch List"
#    Given I am on the "searchPage" page
#    When I tap the "trailerCard1" widget
#    Then I am on the "MediaPage" page
#    When I tap the "addToWatchListButton" button
#    Then I expect the text "Add to watch list" to be present
#    When I tap the "addToWatchListModal" button
#    Then I expect the text "Added to watchlist" to be present
