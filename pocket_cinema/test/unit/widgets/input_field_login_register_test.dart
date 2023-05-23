import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_cinema/view/common_widgets/input_field_login_register.dart';

import '../../testable_widget.dart';

void main() {
  group('TextFormFieldLoginRegister', () {
    late TextEditingController controller;
    late Widget testWidget;

    setUp(() {
      controller = TextEditingController();
      testWidget = TextFormFieldLoginRegister(
        hintText: 'Username',
        controller: controller,
      );
    });

    testWidgets('Widget has correct initial properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(testableWidget(testWidget));

      final textFieldFinder = find.byType(TextFormField);
      final textField = tester.widget<TextFormField>(textFieldFinder);

      expect(textField.controller, equals(controller));
    });

    testWidgets('Entering text updates the controller',
        (WidgetTester tester) async {
      await tester.pumpWidget(testableWidget(testWidget));

      final textFieldFinder = find.byType(TextFormField);
      final textField = tester.widget<TextFormField>(textFieldFinder);

      expect(textField.controller!.text, isEmpty);

      await tester.enterText(textFieldFinder, 'john.doe');
      expect(textField.controller!.text, equals('john.doe'));
      expect(controller.text, equals('john.doe'));
    });
  });
}
