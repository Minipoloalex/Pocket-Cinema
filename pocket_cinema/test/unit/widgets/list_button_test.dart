import 'package:flutter_test/flutter_test.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/view/user_space/widgets/list_button.dart';

import '../../testable_widget.dart';

void main() {
  testWidgets('ListButton displays label and icon', (WidgetTester tester) async {
    const String labelText = 'Button Label';

    bool onPressedCalled = false;
    onPressed() {
      onPressedCalled = true;
    }

    final widget =  ListButton(
        labelText: labelText,
        onPressed: onPressed,
        icon: const HeroIcon(HeroIcons.checkCircle,
                          style: HeroIconStyle.solid),
      );

    await tester.pumpWidget(testableWidget(widget));

    expect(find.text(labelText), findsOneWidget);
    expect(find.byType(HeroIcon), findsOneWidget);

    await tester.tap(find.byType(HeroIcon));
    expect(onPressedCalled, true);
  });
}
