import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_cinema/view/common_widgets/topbar_logo.dart';

import '../../testable_widget.dart';

void main() {
  group('Top bar logo widget', () {
    testWidgets('renders logo and app name correctly', (WidgetTester tester) async {
      await tester.pumpWidget(testableWidget(const TopBarLogo()));

      final logoFinder = find.byType(SvgPicture);
      expect(logoFinder, findsOneWidget);

      final appNameFinder = find.text('Pocket Cinema');
      expect(appNameFinder, findsOneWidget);

      final paddingFinder = find.byType(Padding);
      final paddingWidget = paddingFinder.evaluate().first.widget as Padding;
      expect(paddingWidget.padding.vertical, 20.0);
    });
  });
}
