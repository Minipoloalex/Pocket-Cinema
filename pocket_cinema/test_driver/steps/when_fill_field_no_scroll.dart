import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric whenFillFieldNoScroll() {
  return given2<String, String, FlutterWorld>(
    'I fill the {string} field without scrolling with {string}',
        (key, value, context) async {
      await FlutterDriverUtils.waitForFlutter(context.world.driver);
      final finder = find.byValueKey(key);
      await FlutterDriverUtils.enterText(
        context.world.driver!,
        finder,
        value,
      );
      await FlutterDriverUtils.waitForFlutter(context.world.driver);
    },
  );
}
