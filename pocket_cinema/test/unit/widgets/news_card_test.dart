import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pocket_cinema/model/news.dart';
import 'package:pocket_cinema/view/home/widgets/news_widget.dart';
import 'package:pocket_cinema/view/home/widgets/news_page.dart';

import '../../testable_widget.dart';

void main() {
  testWidgets('NewsCard displays news title and date', (WidgetTester tester) async {
    final news = News(
      title: 'Test news',
      date: DateTime.now(),
      image: 'https://example.com/image.jpg',
      description: "",
      link: "",
    );
    final widget = NewsCard(news: news);

    await mockNetworkImagesFor(() => tester.pumpWidget(testableWidget(widget)));

    final titleFinder = find.text(news.title);
    final dateFinder = find.text(DateFormat('yyyy-MM-dd – kk:mm').format(news.date));

    expect(titleFinder, findsOneWidget);
    expect(dateFinder, findsOneWidget);
  });

  testWidgets('NewsCard navigates to NewsPage when tapped', (WidgetTester tester) async {
    final news = News(
      title: 'Test news',
      date: DateTime.now(),
      image: 'https://example.com/image.jpg',
      description: "",
      link: "",
    );
    final widget = NewsCard(news: news);
    await mockNetworkImagesFor(() => tester.pumpWidget(testableWidget(widget)));

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    expect(find.byType(NewsPage), findsOneWidget);
  });
}

