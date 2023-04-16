import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:pocket_cinema/model/comment.dart';
import 'package:pocket_cinema/view/media/widgets/comment_widget.dart';

import '../../testable_widget.dart';

void main() {
  final comment = Comment(
    mediaID: '123',
    userId: '123',
    username: 'John',
    content: 'Great movie!',
    createdAt: Timestamp.now(),
  );

  testWidgets('CommentWidget displays comment information', (WidgetTester tester) async {
    await tester.pumpWidget(testableWidget(CommentWidget(comment: comment)));

    final usernameTextFinder = find.text('${comment.username}: ${comment.content}');
    final dateTextFinder = find.text(DateFormat('hh:mm MM/dd/yyyy').format(comment.createdAt.toDate()));

    expect(usernameTextFinder, findsOneWidget);
    expect(dateTextFinder, findsOneWidget);
  });

  testWidgets('CommentWidget displays comment with correct decoration', (WidgetTester tester) async {
    await tester.pumpWidget(testableWidget(CommentWidget(comment: comment)));

    final container = tester.widget<Container>(find.byType(Container));
    expect(container.decoration, BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: ThemeData().cardColor,
    ));
  });
}
