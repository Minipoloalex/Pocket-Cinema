import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pocket_cinema/model/news.dart';
import 'package:pocket_cinema/model/string_capitalize.dart';
import 'package:pocket_cinema/view/common_widgets/go_back_button.dart';
import 'package:pocket_cinema/view/home/widgets/news_page.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../mock_url_launcher.dart';
import '../../testable_widget.dart';

void main() {
  group('NewsPage', () {
    late News news;
    late Widget testWidget;

    setUp(() {
      news = News(
        title: 'Test News',
        date: DateTime.now(),
        description: 'This is a test news article.',
        link: 'https://example.com',
        image: 'https://example.com/image.jpg',
      );
      testWidget =  NewsPage(news: news);
    });

    testWidgets('Widget has correct initial properties', (WidgetTester tester) async {
      
      await mockNetworkImagesFor(() => tester.pumpWidget(testableWidget(testWidget)));

      final appBarFinder = find.byType(AppBar);
      final goBackButtonFinder = find.byType(GoBackButton);
      final listViewFinder = find.byType(ListView);
      final titleFinder = find.text('Test News');
      final dateFinder = find.text(timeago.format(news.date).capitalize());
      final descriptionFinder = find.text('This is a test news article.');
      final continueReadingButtonFinder = find.byKey(const Key('continueReadingButton'));

      expect(appBarFinder, findsOneWidget);
      expect(goBackButtonFinder, findsOneWidget);
      expect(listViewFinder, findsOneWidget);
      expect(titleFinder, findsOneWidget);
      expect(dateFinder, findsOneWidget);
      expect(descriptionFinder, findsOneWidget);
      expect(continueReadingButtonFinder, findsOneWidget);
    });

    testWidgets('Tapping the GoBackButton triggers navigation', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(testableWidget(testWidget)));

      final goBackButtonFinder = find.byKey(const Key('goBackButton'));
      await tester.tap(goBackButtonFinder);
      await tester.pumpAndSettle();

      expect(find.byType(NewsPage), findsNothing);

    });

    testWidgets('Failed URL launch shows Fluttertoast', (WidgetTester tester) async {
      MockUrlLauncher mock = MockUrlLauncher();
      UrlLauncherPlatform.instance = mock;

      mock
        ..setLaunchExpectations(
          url: news.link,
          useSafariVC: false,
          useWebView: false,
          universalLinksOnly: false,
          enableJavaScript: true,
          enableDomStorage: true,
          headers: <String, String>{},
          webOnlyWindowName: null,
        )
        ..setResponse(false);

      await mockNetworkImagesFor(() => tester.pumpWidget(testableWidget(testWidget)));

      await tester.pumpAndSettle();
      final continueReadingButtonFinder = find.byKey(const Key('continueReadingButton'));
      await tester.tap(continueReadingButtonFinder);

      expect(mock.canLaunchCalled, isFalse);
      expect(mock.launchCalled, isTrue);
    });
  });
}
