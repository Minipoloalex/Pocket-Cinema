Feature: Seeing trailers and in theaters movies
As a user,
I want to see trailers of trending movies and series
So that I can decide which media to watch

  Background:
    Given I am not authenticated
    And I authenticate as "myUsername" with password "myPassword"
    And I am on the "HomePage" page
    When I tap the "searchNavigationButton" button
    Then I am on the "SearchPage" page

  Scenario: Search page with visible trailers and in theaters movies
    Given I am on the "SearchPage" page
    Then I expect the text "In Theaters" to be present
    And I expect the text "Trending Trailers" to be present

  Scenario: Moving to in theaters page
    Given I am on the "SearchPage" page
    When I tap the "InTheaters" label
    Then I am on the "MediaListPage" page
    And I expect the text "In Theaters" to be present
    When I tap the back button
    Then I am on the "SearchPage" page

  Scenario: Going to media details page from trending trailer
    Given I am on the "SearchPage" page
    When I tap the "TrailerCard1" widget
    Then I am on the "MediaPage" page
    When I tap the "backButton" button
    Then I am on the "SearchPage" page

#  Scenario: Watching a trending trailer
#    Given I am on the "SearchPage" page
#    When I pause for 5 seconds
#    When I tap the "playTrailer1" button without scrolling it into view
#    When I pause for 5 seconds
#    Then I am on the "TrailerPage" page
#    When I tap the back button
#    And I tap the "backButton" button
#    Then I am on the "SearchPage" page
