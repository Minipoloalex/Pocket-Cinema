import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric thenTapButton() {
  return then1<String, FlutterWorld>(
    'I tap the {string} button',
        (key, context) async {
      final button = find.byValueKey(key);
      await FlutterDriverUtils.tap(context.world.driver, button);
    },
  );
}
