Feature: Accessing user space and lists
  As a user,
  I want to be able to create lists of movies/series that are displayed on a library,
  so that I can categorize them the way I want (e.g. by genre)

  Background:
    Given I am not authenticated
    And I authenticate as "myUsername" with password "myPassword"
    And I am on the "HomePage" page
    When I tap the "my spaceNavigationButton" button
    Then I am on the "UserSpacePage" page

  Scenario: Entering watched list
    Given I am on the "UserSpacePage" page
    When I tap the "watchedListButton" button
    Then I am on the "MediaListPage" page
    And I expect the text "Watched" to be present
    When I tap the back button
    Then I am on the "UserSpacePage" page
    | a                               |
    | tooo_bigg_name_21char           |
    | tooooooooooooooooooooooooooBIG  |
