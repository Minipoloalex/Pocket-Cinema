import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/model/media.dart';

List<Media> _mediaToWatch = const [
    Media("Mad Men", "https://br.web.img3.acsta.net/pictures/21/02/10/20/02/0834301.jpg"),
    Media("Dr. House", "https://www.themoviedb.org/t/p/original/lW7MvZ4m49IUj2UrUu4z0xVVl81.jpg"),
    Media("Sherlock", "https://cdn.europosters.eu/image/750/posters/sherlock-destruction-i34921.jpg"),
    Media("The Walking Dead", "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/81UvZYUoOJL.jpg"),
    Media("Dexter", "https://cdn.europosters.eu/image/750/posters/dexter-shrinkwrapped-i14382.jpg"),
    Media("Patrick Melrose", "https://m.media-amazon.com/images/M/MV5BMjIwNzk4OTQ1NV5BMl5BanBnXkFtZTgwMjE0NDMyNTM@._V1_.jpg"),
];

final toWatchListProvider = FutureProvider<List<Media>>((ref) async {
  // Fake get call
  final mediaToWatch = await Future.delayed(
    const Duration(seconds: 1),
    () => _mediaToWatch,
  );

  return mediaToWatch;
});


// Return the lists of the user
final listsProvider = FutureProvider.autoDispose<List>((ref) async {
  return [];
});
