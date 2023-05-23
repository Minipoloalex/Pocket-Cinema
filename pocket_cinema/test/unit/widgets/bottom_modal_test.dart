import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/bottom_modal.dart';
import 'package:pocket_cinema/view/common_widgets/personal_lists.dart';

import '../../testable_widget.dart';

void main() {
  group('Bottom modal widget', () {
    final media = Media(
      id: '1',
      name: 'Media Name',
      posterImage: 'assets/images/poster_image.jpg',
      backgroundImage: 'assets/images/background_image.jpg',
      description: 'Media Description',
      type: MediaType.movie,
    );

    testWidgets('Displays Personal lists and add to watch button',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(ProviderScope(
              child: testableWidget(BottomModal(
            media: media,
          )))));

      final addToWatchButtonFinder = find.byWidgetPredicate((widget) =>
          widget is Container &&
          widget.child is ElevatedButton &&
          (widget.child as ElevatedButton).child is Padding &&
          ((widget.child as ElevatedButton).child as Padding).child is Text &&
          (((widget.child as ElevatedButton).child as Padding).child as Text)
                  .data ==
              'Add to Watch');
      expect(addToWatchButtonFinder, findsOneWidget);
      expect(find.byType(PersonalLists), findsOneWidget);
    });
  });
}
