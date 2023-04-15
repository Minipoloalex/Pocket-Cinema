Feature: Login and Logout
  Scenario Outline: Valid login information
    Given I am on the "LoginPage" page
    When I fill the "userIdField" field with "<userIdField>"
    And I fill the "passwordLoginField" field with "<passwordField>"
    And I tap the "loginButton" button
    Then I am on the "HomePage" page

  # Changing to the library page (where there is a logout button)
    Given I am on the "HomePage" page
    When I tap the "libraryNavigationButton" button
    Then I am on the "LibraryPage" page

  # Logging out
    Given I am on the "LibraryPage" page
    When I tap the "logoutButton" button
    Then I am on the "LoginPage" page
    Examples:
      | userIdField     | passwordField |
      | admin@gmail.com | 123456        |
      | admin           | 123456        |


  Scenario: Changing to register page
    Given I am on the "LoginPage" page
    When I tap the "registerTab" label
    Then I am on the "RegisterPage" page
    And I restart the app

  Scenario: Trying to change to login page when already there
    Given I am on the "LoginPage" page
    When I tap the "loginTab" label
    Then I am on the "LoginPage" page

  # TODO: create 2 different scenario outlines with checks for error messages
  Scenario Outline: Invalid login information
    Given I am on the "LoginPage" page
    When I fill the "userIdField" field with "<userIdField>"
    And I fill the "passwordLoginField" field with "<passwordField>"
    And I tap the "loginButton" button
    Then I am on the "LoginPage" page

    Examples:
    | userIdField             | passwordField |
    | a@gmail.com             | pass1         |
    | qwertyuiop@hotmail.com  | qwertyuiop    |
    | invalid_username        | invalid_pass  |
    |                         |               |
