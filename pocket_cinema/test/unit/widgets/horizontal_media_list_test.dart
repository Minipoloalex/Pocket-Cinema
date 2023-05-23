import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/horizontal_media_list.dart';
import 'package:pocket_cinema/view/common_widgets/poster.dart';
import 'package:pocket_cinema/view/media_list/media_list.dart';

import '../../testable_widget.dart';

void main() {
  testWidgets('HorizontalMediaList displays name and media posters',
      (WidgetTester tester) async {
    final List<Media> media = [
      Media(id: "", name: 'Movie 1', posterImage: 'image1.jpg'),
      Media(id: "", name: 'Movie 2', posterImage: 'image2.jpg'),
      Media(id: "", name: 'Movie 3', posterImage: 'image3.jpg'),
    ];

    final widget = HorizontalMediaList(name: 'Test List', media: media);

    await mockNetworkImagesFor(() => tester.pumpWidget(testableWidget(widget)));

    expect(find.text('Test List'), findsOneWidget);
    expect(find.byType(Poster), findsNWidgets(media.length));

    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    expect(find.byType(MediaListPage), findsOneWidget);
  });

  testWidgets('HorizontalMediaList displays no media when media list is empty',
      (WidgetTester tester) async {
    final List<Media> media = [];
    final widget = HorizontalMediaList(name: 'Empty List', media: media);

    await mockNetworkImagesFor(() => tester.pumpWidget(testableWidget(widget)));

    expect(find.text('Empty List'), findsOneWidget);

    expect(find.byType(Poster), findsNothing);
  });
}
