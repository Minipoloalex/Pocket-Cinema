import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class GivenPage extends Given1WithWorld<String, FlutterWorld> {
  GivenPage() : super(StepDefinitionConfiguration()..timeout = const Duration(seconds:15));
  @override
  Future<void> executeStep(String input) async {
    FlutterDriverUtils.waitForFlutter(world.driver);
    final page = find.byType(input);
    expect(
        await FlutterDriverUtils.isPresent(
            world.driver,
            page,
            timeout: const Duration(seconds: 5)),
        true,
        reason: "Page $input is not present",
    );
  }

  @override
  RegExp get pattern => RegExp(r"I am on the {string} page");
}

class ThenPage extends Then1WithWorld<String, FlutterWorld> {
  ThenPage() : super(StepDefinitionConfiguration()..timeout = const Duration(seconds:15));
  @override
  Future<void> executeStep(String input) async {
    FlutterDriverUtils.waitForFlutter(world.driver);
    final page = find.byType(input);
    expect(
      await FlutterDriverUtils.isPresent(
          world.driver,
          page,
          timeout: const Duration(seconds: 5)),
      true,
      reason: "Page $input is not present",
    );
  }

  @override
  RegExp get pattern => RegExp(r"I am on the {string} page");
}


