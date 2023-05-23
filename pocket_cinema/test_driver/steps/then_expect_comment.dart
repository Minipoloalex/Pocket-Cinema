import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class ThenExpectComment extends Given2WithWorld<String, String, FlutterWorld> {
  @override
  ThenExpectComment() : super(StepDefinitionConfiguration()..timeout = const Duration(seconds:15));
  @override
  Future<void> executeStep(String username, String text) async {
    await FlutterDriverUtils.waitForFlutter(world.driver);
    final comment = find.text(text);
    final commentUsername = find.text(username);

    final textPresent = await FlutterDriverUtils.isPresent(
      world.driver, comment, timeout: const Duration(seconds: 10)
    );
    final usernamePresent = await FlutterDriverUtils.isPresent(
        world.driver, commentUsername, timeout: const Duration(seconds: 10)
    );
    expect(textPresent, true, reason: "Comment $text is not present");
    expect(usernamePresent, true, reason: "Username $username is not present");
    await FlutterDriverUtils.waitForFlutter(world.driver);
  }

  @override
  Pattern get pattern => "I expect the comment {string} {string} to be present";
}
