import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';


class ThenNoResultsFound extends Then1WithWorld<String, FlutterWorld> {
  ThenNoResultsFound() : super(StepDefinitionConfiguration()..timeout = const Duration(seconds:10));
  @override
  Future<void> executeStep(String input) async {
    FlutterDriverUtils.waitForFlutter(world.driver);
    if (input == "movies") {
      final movies = find.byValueKey("moviesListView");
      expect(
        await FlutterDriverUtils.isPresent(
            world.driver,
            movies,
            timeout: const Duration(seconds: 5)),
        true,
        reason: "Movies tab is not present",
      );

    } else if (input == "series") {
      final series = find.byValueKey("seriesListView");
      expect(
        await FlutterDriverUtils.isPresent(
            world.driver,
            series,
            timeout: const Duration(seconds: 5)),
        true,
        reason: "Series tab is not present",
      );
    }
    final searchResultsFinder = find.byType("SearchResult");

    expect(
      await FlutterDriverUtils.isAbsent(
          world.driver,
          searchResultsFinder,
          timeout: const Duration(seconds: 5)),
      true,
      reason: "Search results are present",
    );
    await FlutterDriverUtils.waitForFlutter(world.driver);

  }

  @override
  RegExp get pattern => RegExp(r"I find no results on the (movies|series) tab");
}
