import 'dart:async';

import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';

import 'steps/given_authenticate.dart';
import 'steps/given_not_authenticated.dart';
import 'steps/on_page_step.dart';
import 'steps/then_no_results_found.dart';
import 'steps/when_fill_field_no_scroll.dart';
import 'steps/when_tap_name_media.dart';
import 'steps/then_expect_present.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
  ..features = [Glob(r"test_driver/features/lists.feature")]
  ..reporters = [
    ProgressReporter(),
    TestRunSummaryReporter(),
    JsonReporter(path: './report.json'),
  ]
  ..stepDefinitions = [
    GivenPage(),
    ThenPage(),
    GivenNotAuthenticated(),
    GivenAuthenticate(),
    ThenNoResultsFound(),
    whenFillFieldNoScroll(),
    WhenTapNameMedia(),
    ThenExpectPresent(),
  ]
  ..customStepParameterDefinitions = []
  ..restartAppBetweenScenarios = false
  ..flutterBuildTimeout = const Duration(minutes: 2)
  ..targetAppPath = "test_driver/app.dart";
  return GherkinRunner().execute(config);
}
