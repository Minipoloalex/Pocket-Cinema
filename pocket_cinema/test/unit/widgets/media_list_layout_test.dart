import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/poster.dart';
import 'package:pocket_cinema/view/media_list/media_list_layout.dart';

import '../../testable_widget.dart';

void main() {
  group('SearchResult widget', () {
    final media1 = Media(
      id: '1',
      name: 'Media Name 1',
      posterImage: 'assets/images/poster_image1.jpg',
      backgroundImage: 'assets/images/background_image.jpg',
      description: 'Media Description',
      type: MediaType.movie,
    );
    final media2 = Media(
      id: '2',
      name: 'Media Name 2',
      posterImage: 'assets/images/poster_image2.jpg',
      backgroundImage: 'assets/images/background_image.jpg',
      description: 'Media Description',
      type: MediaType.movie,
    );
    final media3 = Media(
      id: '3',
      name: 'Media Name 3',
      posterImage: 'assets/images/poster_image3.jpg',
      backgroundImage: 'assets/images/background_image.jpg',
      description: 'Media Description',
      type: MediaType.movie,
    );

    testWidgets('should display media information but no button', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(
          ProviderScope(child: testableWidget(
              MediaListPageLayout(
                name: 'Media List',
                mediaList: [media1, media2, media3],
              )
          ))
        )
      );

      expect(find.text(media1.name), findsOneWidget);
      expect(find.text(media2.name), findsOneWidget);
      expect(find.text(media3.name), findsOneWidget);

      final posterImageFinder = find.byWidgetPredicate((widget) =>
      widget is GestureDetector &&
          widget.child is Poster &&
          (widget.child as Poster)
              .url
              .toString()
              .contains(media2.posterImage));
      expect(posterImageFinder, findsOneWidget);

      expect(find.byType(IconButton), findsNothing);
    });

    testWidgets('should display delete list button', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(
          ProviderScope(child: testableWidget(
              MediaListPageLayout(
                name: 'Media List',
                mediaList: [media1, media2, media3],
                listId: '1',
              )
          ))
        )
      );

      expect(find.byType(IconButton), findsOneWidget);
    });
  });
}


