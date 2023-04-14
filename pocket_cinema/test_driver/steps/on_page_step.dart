import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class GivenPage extends Given1WithWorld<String, FlutterWorld> {
  GivenPage() : super(StepDefinitionConfiguration()..timeout = const Duration(seconds:10));
  @override
  Future<void> executeStep(String input) async {
    final page = find.byType(input);
    await FlutterDriverUtils.isPresent(world.driver, page);
  }

  @override
  RegExp get pattern => RegExp(r"I am on the {string} page");
}

class ThenPage extends Then1WithWorld<String, FlutterWorld> {
  ThenPage() : super(StepDefinitionConfiguration()..timeout = const Duration(seconds:10));
  @override
  Future<void> executeStep(String input) async {
    final page = find.byType(input);
    await FlutterDriverUtils.isPresent(world.driver, page);
  }

  @override
  RegExp get pattern => RegExp(r"I am on the {string} page");
}


