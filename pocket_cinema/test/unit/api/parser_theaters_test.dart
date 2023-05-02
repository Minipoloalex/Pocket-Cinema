import 'dart:io';
import 'package:pocket_cinema/controller/parser.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Searching movies in near theaters', () {
    test('throws an exception when given an empty JSON string', () {
      expect(() => Parser.moviesInNearTheaters(''), throwsException);
    });

    test('throws an exception when given an HTML string with no movie data', () {
      expect(() => Parser.moviesInNearTheaters('{"d":[]}'), throwsException);
    });

    // Test case 3: Verify that an HTML string with movie data returns a list of Media objects with the expected properties.

    test('searching titanic', () {
      final file = File('test/resources/theaters.html').readAsStringSync();
      final parsed = Parser.moviesInNearTheaters(file);

      final evilDeadRise = Media(
        id: "tt13345606",
        name: "Evil Dead Rise",
        posterImage: "https://m.media-amazon.com/images/M/MV5BMmZiN2VmMjktZDE5OC00ZWRmLWFlMmEtYWViMTY4NjM3ZmNkXkEyXkFqcGdeQXVyMTI2MTc2ODM3._V1_UY209_CR0,0,140,209_AL_.jpg",
      );

      expect(parsed.length, 26); // There are 26 movies in theaters

      // Checking the first
      expect(parsed[0].id, evilDeadRise.id);
      expect(parsed[0].name, evilDeadRise.name);
      expect(parsed[0].posterImage, evilDeadRise.posterImage);
    });
  }); 
}