Feature: News on movies/series
  As a user
  I want to be able to access the latest news on movies/series
  so that I can always be updated about the cinema world.

  Background:
    Given I am not authenticated
    And I authenticate as "myUsername" with password "myPassword"

  Scenario: I want to see news on movies/series
    Given I am on the "HomePage" page
    When I tap the "newsCard1" button
    Then I am on the "NewsPage" page
    And I tap the "goBackButton" button

  Scenario: Going back from a specific news page
    Given I am on the "HomePage" page
    And I tap the "newsCard1" button
    When I tap the "goBackButton" button
    Then I am on the "HomePage" page

#  Scenario: Selecting the "Continue Reading" button
#    Given I am on the "HomePage" page
#    And I tap the "newsCard1" button
#    When I tap the "continueReadingButton" button
#    And I pause for 10 seconds
#    And I tap the back button
#    Then I am on the "HomePage" page
