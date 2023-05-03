import 'dart:io';
import 'package:pocket_cinema/controller/parser.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Searching medias', () {
    test('searching titanic', () {
      final file = File('test/resources/search_titanic.json');

      final json = file.readAsStringSync();
      final parsed = Parser.searchMedia(json);


      final titanic = Media(
        id: "tt0120338",
        name: "Titanic",
        posterImage: "https://m.media-amazon.com/images/M/MV5BMDdmZGU3NDQtY2E5My00ZTliLWIzOTUtMTY4ZGI1YjdiNjk3XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_.jpg",
        backgroundImage: "https://m.media-amazon.com/images/M/MV5BYzExZDkwNzYtYmI0Mi00OThhLWFhNmMtZTZjYWU2MTdkMDAzXkEyXkFqcGdeQWRpZWdtb25n._V1_.jpg",
        rating: "7.9",
        nRatings: "1215514",
        description: 'A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.',
        type: MediaType.movie,
      );

      expect(parsed.length, 5);
      expect(parsed[0].id, titanic.id);
      expect(parsed[0].name, titanic.name);
      expect(parsed[0].posterImage, titanic.posterImage);
    });
  }); 
}