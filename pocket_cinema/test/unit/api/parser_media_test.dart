import 'dart:io';

import 'package:pocket_cinema/controller/parser.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Parser a specific media', () {
    test('throws an exception when given an empty JSON string', () {
      expect(() => Parser.media(''), throwsException);
    });

    test('returns a Media object with the expected properties when given a JSON string with media data', () {
      final jsonString = File('test/resources/titanic.json').readAsStringSync();

      final expectedMedia = Media(
        id: "tt0120338",
        name: "Titanic",
        posterImage: "https://m.media-amazon.com/images/M/MV5BMDdmZGU3NDQtY2E5My00ZTliLWIzOTUtMTY4ZGI1YjdiNjk3XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_.jpg",
        backgroundImage: "https://m.media-amazon.com/images/M/MV5BYzExZDkwNzYtYmI0Mi00OThhLWFhNmMtZTZjYWU2MTdkMDAzXkEyXkFqcGdeQWRpZWdtb25n._V1_.jpg",
        rating: "7.9",
        nRatings: 1215514,
        description: 'A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.',
        type: MediaType.movie,
      );

      final parser = Parser.media(jsonString);

      expect(parser.id, expectedMedia.id);
      expect(parser.name, expectedMedia.name);
      expect(parser.posterImage, expectedMedia.posterImage);
      expect(parser.backgroundImage, expectedMedia.backgroundImage);
      expect(parser.rating, expectedMedia.rating);
      expect(parser.nRatings, expectedMedia.nRatings);
      expect(parser.description, expectedMedia.description);
      expect(parser.type, expectedMedia.type);
      expect(parser.releaseDate, expectedMedia.releaseDate);
      expect(parser.trailer, expectedMedia.trailer);
      expect(parser.trailerDuration, expectedMedia.trailerDuration);
    });
  }); 
}