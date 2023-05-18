import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class GivenNotAuthenticated extends GivenWithWorld<FlutterWorld> {
  GivenNotAuthenticated() : super(StepDefinitionConfiguration()..timeout = const Duration(seconds:25));
  @override
  Future<void> executeStep() async {
    final loginPage = find.byType('LoginPage');
    final loginPageIsPresent = await FlutterDriverUtils.isPresent(world.driver, loginPage, timeout: const Duration(seconds: 5));
    if (loginPageIsPresent) return;

    final homePage = find.byType('HomePage');
    final homePageIsPresent = await FlutterDriverUtils.isPresent(world.driver, homePage, timeout: const Duration(seconds: 5));
    if (homePageIsPresent) {
      tapNavigationButton(world.driver);
    }
    else {
      final searchPage = find.byType('SearchPage');
      final searchPageIsPresent = await FlutterDriverUtils.isPresent(world.driver, searchPage, timeout: const Duration(seconds: 5));
      if (searchPageIsPresent) tapNavigationButton(world.driver);
    }
    await FlutterDriverUtils.waitForFlutter(world.driver);

    final userSpacePage = find.byType('UserSpacePage');
    expect(
      await FlutterDriverUtils.isPresent(world.driver, userSpacePage, timeout: const Duration(seconds: 2)),
      true,
      reason: "Login, Home, Search and UserSpace pages are not present",
    );

    final logoutButton = find.byValueKey('logoutButton');
    await FlutterDriverUtils.tap(world.driver, logoutButton);
    await FlutterDriverUtils.waitForFlutter(world.driver);
  }
  @override
  RegExp get pattern => RegExp(r"I am not authenticated");

  void tapNavigationButton(FlutterDriver? driver) async {
    final button = find.byValueKey("my spaceNavigationButton");
    await FlutterDriverUtils.tap(driver, button);
    await FlutterDriverUtils.waitForFlutter(driver);
  }
}
