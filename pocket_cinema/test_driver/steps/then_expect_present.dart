import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class ThenExpectPresent extends Then1WithWorld<String, FlutterWorld> {
  ThenExpectPresent()
      : super(StepDefinitionConfiguration()..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep(String input) async {
    FlutterDriverUtils.waitForFlutter(world.driver);
    final widget = find.byValueKey(input);
    expect(
      await FlutterDriverUtils.isPresent(
          world.driver,
          widget,
          timeout: const Duration(seconds: 5)),
      true,
      reason: "Widget $input is not present",
    );
  }

  @override
  RegExp get pattern => RegExp(r"I expect the {string} widget to be present");
}
