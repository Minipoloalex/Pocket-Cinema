import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class GivenNotAuthenticated extends GivenWithWorld<FlutterWorld> {
  GivenNotAuthenticated() : super(StepDefinitionConfiguration()..timeout = const Duration(seconds:15));
  @override
  Future<void> executeStep() async {
    final loginPage = find.byType('LoginPage');
    final loginPageIsPresent = await FlutterDriverUtils.isPresent(world.driver, loginPage, timeout: const Duration(seconds: 5));
    if (loginPageIsPresent) return;

    final newsPage = find.byType('HomePage');
    expect(
      await FlutterDriverUtils.isPresent(world.driver, newsPage, timeout: const Duration(seconds: 2)),
      true,
      reason: "Both pages HomePage and LoginPage are not present",
    );

    final button = find.byValueKey("my spaceNavigationButton");
    await FlutterDriverUtils.tap(world.driver, button);
    await FlutterDriverUtils.waitForFlutter(world.driver);

    final userSpacePage = find.byType('UserSpacePage');
    expect(
      await FlutterDriverUtils.isPresent(world.driver, userSpacePage, timeout: const Duration(seconds: 1)),
      true,
      reason: "UserSpacePage is not present",
    );

    final logoutButton = find.byValueKey('logoutButton');
    await FlutterDriverUtils.tap(world.driver, logoutButton);
  }

  @override
  RegExp get pattern => RegExp(r"I am not authenticated");
}
