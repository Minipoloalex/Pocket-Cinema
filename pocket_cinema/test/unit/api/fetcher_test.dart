import 'package:pocket_cinema/controller/fetcher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('normal behaviour', () {

    test('get movies in near theaters', () {
      expect(() async => await Fetcher.getMoviesInNearTheaters(), returnsNormally);
    });
    test('get trending trailers', () {
      expect(() async => await Fetcher.getTrendingTrailers(), returnsNormally);
    });
    test('search media', () {
      expect(() async => await Fetcher.searchMedia('titanic'), returnsNormally);
    });
    test('get media details', () {
      expect(() async => await Fetcher.getMedia('123'), returnsNormally);
    });
    test('get movie trailer playbacks', (){
      expect(() async => await Fetcher.getMovieTrailerPlaybacks('123'), returnsNormally);
    });
  });
}
