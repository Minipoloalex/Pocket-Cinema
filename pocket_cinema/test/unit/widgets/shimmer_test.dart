import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_cinema/view/common_widgets/shimmer.dart';

import '../../testable_widget.dart';

void main() {
  testWidgets('ShimmerEffect displays child widget',
      (WidgetTester tester) async {
    final widget = ShimmerEffect(
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
    );
    await tester.pumpWidget(testableWidget(widget));

    // Verify that the child widget is displayed
    expect(find.byType(Container), findsOneWidget);
    expect(tester.widget<Container>(find.byType(Container)).color,
        equals(Colors.red));
  });
}
