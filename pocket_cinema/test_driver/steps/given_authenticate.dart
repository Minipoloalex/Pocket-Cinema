import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class GivenAuthenticate extends Given2WithWorld<String, String, FlutterWorld> {
  GivenAuthenticate() : super(StepDefinitionConfiguration()..timeout = const Duration(seconds:10));
  @override
  Future<void> executeStep(String username, String password) async {
    final loginPage = find.byType('LoginPage');
    final loginPageIsPresent = await FlutterDriverUtils.isPresent(world.driver, loginPage, timeout: const Duration(seconds: 5));
    expect(
      loginPageIsPresent,
      true,
      reason: "LoginPage is not present",
    );

    final userIdField = find.byValueKey("userIdField");
    await FlutterDriverUtils.enterText(world.driver, userIdField, username, timeout: const Duration(seconds: 1));
    await FlutterDriverUtils.waitForFlutter(world.driver);

    final passwordField = find.byValueKey("passwordLoginField");
    await FlutterDriverUtils.enterText(world.driver, passwordField, password, timeout: const Duration(seconds: 1));
    await FlutterDriverUtils.waitForFlutter(world.driver);

    final loginButton = find.byValueKey("loginButton");
    await FlutterDriverUtils.tap(world.driver, loginButton);
    await FlutterDriverUtils.waitForFlutter(world.driver);
  }

  @override
  RegExp get pattern => RegExp(r"I authenticate as {string} with password {string}");
}
