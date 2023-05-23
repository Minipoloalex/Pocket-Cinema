import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_cinema/view/register/register.dart';

import '../../testable_widget.dart';

void main() {
  group('RegisterPage', () {
    late RegisterPage widget;

    setUp(() {
      widget = const RegisterPage();
    });

    testWidgets('Check if all text fields are present', (WidgetTester tester) async {
      await tester.pumpWidget(testableWidget(widget));

      expect(find.byKey(const Key("emailField")), findsOneWidget);
      expect(find.byKey(const Key("usernameField")), findsOneWidget);
      expect(find.byKey(const Key("passwordRegisterField")), findsOneWidget);
      expect(find.byKey(const Key("confirmPasswordField")), findsOneWidget);
    });
  });
}
