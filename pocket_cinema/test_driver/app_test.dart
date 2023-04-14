import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';

import 'steps/on_page_step.dart';
import 'steps/then_tap_button.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
  ..features = [Glob(r"test_driver/features/**.feature")]
  ..reporters = [
    ProgressReporter(),
    // TestRunReporter(),
    TestRunSummaryReporter(),
    JsonReporter(path: './report.json'),
  ]
  ..stepDefinitions = [
    GivenPage(),
    ThenPage(),
    WhenFillFieldStep(),
    WhenTapWidget(),
    TapWidgetWithTextStep(),
    thenTapButton(),
  ]
  ..customStepParameterDefinitions = []
  ..restartAppBetweenScenarios = false
  ..targetAppPath = "test_driver/app.dart";
  return GherkinRunner().execute(config);
}
