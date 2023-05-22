import 'package:pocket_cinema/model/media.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mediaId = '123';
  const name = 'movie title';
  const posterPath = 'poster path';
  final Media media = Media(
    id: mediaId,
    name: name,
    posterImage: posterPath,
  );
  test('equal operator', (){
    final mediaEqual = Media(
      id: mediaId,
      name: name,
      posterImage: posterPath,
    );
    final mediaNotEqual = Media(
      id: '1234',
      name: name,
      posterImage: posterPath,
    );
    expect(media == media, true);
    expect(media == mediaEqual, true);
    expect(media == mediaNotEqual, false);
    expect(media, isNotNull);
  });
  test('hashcode', (){
    expect(media.hashCode, mediaId.hashCode);
    expect(media.hashCode, isNotNull);
  });
}
