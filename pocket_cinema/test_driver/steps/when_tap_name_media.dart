import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class WhenTapNameMedia extends When2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String name, String type) async {
    await FlutterDriverUtils.waitForFlutter(world.driver);

    final mediaFinder = find.byValueKey(name);
    await FlutterDriverUtils.tap(world.driver, mediaFinder);

    await FlutterDriverUtils.waitForFlutter(world.driver);
  }

  @override
  RegExp get pattern => RegExp(r"I tap the {string} (movie|series)");
}
