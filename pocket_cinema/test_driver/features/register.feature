Feature: Registering
  As a user
  I want to be able to register an account
  So that I can access the app


  Scenario: Changing to register page
    Given I am not authenticated
    And I am on the "LoginPage" page
    When I tap the "registerTab" label
    Then I am on the "RegisterPage" page

  Scenario: Trying to change to register page when already there
    Given I am on the "RegisterPage" page
    When I tap the "registerTab" label
    Then I am on the "RegisterPage" page

  Scenario Outline: Register with invalid data or existing user
    Given I am on the "RegisterPage" page
    When I fill the "emailField" field with "<Email>"
    And I fill the "usernameField" field with "<Username>"
    And I fill the "passwordRegisterField" field with "<Password>"
    And I fill the "confirmPasswordField" field with "<ConfirmPassword>"
    And I tap the "registerButton" button
    Then I am on the "RegisterPage" page

    Examples:
    | Email              | Username | Password | ConfirmPassword |
    | admin@gmail.com    | admin    | password | password        |
    |                    |          |          |                 |
    | abcdefg@gmail.com  | abcdefg  | password | differentPass   |
    | new_ghjk@gmail.com | admin    | password | password        |


  Scenario: Changing back to login page
    Given I am on the "RegisterPage" page
    When I tap the "loginTab" label
    Then I am on the "LoginPage" page
