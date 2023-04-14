Feature: Login

  Scenario: Valid login information
    Given I am on the "LoginPage" page
    When I fill the "userIdField" field with "bob@gmail.com"
    And I fill the "passwordField" field with "my_password"
    Then I tap the "LoginButton" button
    And I am on the "HomePage" page
