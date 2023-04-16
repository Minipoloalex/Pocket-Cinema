import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_cinema/model/news.dart';
import 'package:pocket_cinema/view/home/widgets/news_widget.dart';
import 'package:pocket_cinema/view/home/widgets/news_page.dart';

import '../../testable_widget.dart';

void main() {
  group('NewsCard widget', () {
    final news = News(
        image: 'assets/images/news_image.jpg',
        description: 'Test news description',
        date: DateTime.now(),
        content: 'Test news content');

    testWidgets('NewsCard displays correct information', (tester) async {
      await tester.pumpWidget(testableWidget(NewsCard(news: news)));

      final descriptionFinder = find.text(news.description);
      expect(descriptionFinder, findsOneWidget);

      final dateFinder = find.text(news.date.toString());
      expect(dateFinder, findsOneWidget);
    });

    testWidgets('NewsCard navigates to NewsPage on tap', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NewsCard(news: news),
          ),
          onGenerateRoute: (settings) {
            if (settings.name == '/news') {
              return MaterialPageRoute(
                builder: (context) => NewsPage(news: news),
              );
            }
            return null;
          },
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(find.byType(NewsPage), findsOneWidget);
    });
  });
}
