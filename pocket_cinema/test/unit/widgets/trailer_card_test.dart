import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/search/widgets/trailer_card.dart';

import '../../testable_widget.dart';

void main() {
  group('TrailerCard widget', () {
    final media = Media(
      id: '1',
      name: 'Media Name',
      posterImage: 'assets/images/poster_image.jpg',
      backgroundImage: 'assets/images/background_image.jpg',
      description: 'Media Description',
      type: MediaType.movie,
    );

    testWidgets('should display media information', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(ProviderScope(child: testableWidget(TrailerCard(media: media)))));

      expect(find.text(media.name), findsOneWidget);
      final posterImageFinder = find.byWidgetPredicate((widget) =>
      widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).image is DecorationImage &&
          ((widget.decoration as BoxDecoration).image as DecorationImage).image is FadeInImage &&
          (((widget.decoration as BoxDecoration).image as DecorationImage).image as FadeInImage) is CachedNetworkImageProvider &&
          ((((widget.decoration as BoxDecoration).image as DecorationImage).image as FadeInImage).image as CachedNetworkImageProvider)
              .url
              .toString()
              .contains(media.posterImage));
      expect(posterImageFinder, findsOneWidget);
    });

  });
}
