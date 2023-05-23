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

  Scenario: Entering pocket to watch list
    Given I am on the "UserSpacePage" page
    When I tap the "toWatchList" widget
    Then I am on the "MediaListPage" page
    And I expect the text "In your pocket to Watch" to be present
    When I tap the back button
    Then I am on the "UserSpacePage" page

  Scenario Outline: Adding a list with an invalid name
    Given I am on the "UserSpacePage" page
    When I tap the "addListButton" button
    Then I expect the text "New list name" to be present
    When I fill the "createListField" field with "<listName>"
    And I tap the "submitNewListButton" button
    And I expect the "createListField" widget to be present

    Examples:
    | listName                        |
    |                                 |
    | a                               |
    | tooo_bigg_name_21char           |
    | tooooooooooooooooooooooooooBIG  |
