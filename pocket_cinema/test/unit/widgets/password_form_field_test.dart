import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/view/common_widgets/input_field_login_register.dart';
import 'package:pocket_cinema/view/common_widgets/password_form_field.dart';

import '../../testable_widget.dart';

void main() {
  group('PasswordFormField', () {
    late TextEditingController passwordController;
    late Widget testWidget;

    setUp(() {
      passwordController = TextEditingController();
      testWidget =  PasswordFormField(
            hintText: 'Password',
            passwordController: passwordController,
      );
    });

    testWidgets('Initial state should obscure the text', (WidgetTester tester) async {
      await tester.pumpWidget(testableWidget(testWidget));

      final textFormFieldFinder = find.byType(TextFormFieldLoginRegister);
      final iconButtonFinder = find.byType(HeroIcon);
      
      expect(textFormFieldFinder, findsOneWidget);
      expect(iconButtonFinder, findsOneWidget);

      final textField = tester.widget<TextFormFieldLoginRegister>(textFormFieldFinder);
      final iconButton = tester.widget<HeroIcon>(iconButtonFinder);

      expect(textField.obscureText, isTrue);
      expect(iconButton.icon, equals(HeroIcons.eye));
    });

    testWidgets('Tapping the icon button should toggle obscureText', (WidgetTester tester) async {
      await tester.pumpWidget(testableWidget(testWidget));

      final iconButtonFinder = find.byType(IconButton);
      await tester.tap(iconButtonFinder);
      await tester.pump();

      final textField = tester.widget<TextFormFieldLoginRegister>(find.byType(TextFormFieldLoginRegister));

      expect(textField.obscureText, isFalse);

      await tester.tap(iconButtonFinder);
      await tester.pump();

      final reRenderedTextField = tester.widget<TextFormFieldLoginRegister>(find.byType(TextFormFieldLoginRegister));

      expect(reRenderedTextField.obscureText, isTrue);
    });

    testWidgets('Entering text in the TextFormField updates the controller', (WidgetTester tester) async {
      await tester.pumpWidget(testableWidget(testWidget));

      final textFieldFinder = find.byType(TextFormFieldLoginRegister);
      final textField = tester.widget<TextFormFieldLoginRegister>(textFieldFinder);

      expect(textField.controller.text, isEmpty);

      await tester.enterText(textFieldFinder, 'password');
      expect(textField.controller.text, equals('password'));
      expect(passwordController.text, equals('password'));
    });
  });
}
