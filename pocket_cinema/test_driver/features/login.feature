Feature: Login

  Scenario: Valid login information
    Given I am on the "LoginPage" page
    When I fill the "userIdField" field with "admin@gmail.com"
    And I fill the "passwordField" field with "123456"
    Then I tap the "LoginButton" button
    And I am on the "HomePage" page

  Scenario: Changing to the library page (where there is a logout button)
    Given I am on the "HomePage" page
    When I tap the "LibraryNavigationButton" button
    Then I am on the "LibraryPage" page

  Scenario: Logging out
    Given I am on the "LibraryPage" page
    When I tap the "LogoutButton" button
    Then I am on the "LoginPage" page
