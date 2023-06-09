import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/fetcher.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:pocket_cinema/controller/parser.dart';
import 'package:pocket_cinema/model/comment.dart';
import 'package:pocket_cinema/model/media.dart';

final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

final searchResultsProvider =
    FutureProvider.autoDispose<List<Media>>((ref) async {
  final searchQuery = ref.watch(searchQueryProvider);

  if(searchQuery.isEmpty) return [];

  final String response = await Fetcher.searchMedia(searchQuery);
  final List<Media> medias = Parser.searchMedia(response);

  return medias;
});

final searchMoviesProvider =
    FutureProvider.autoDispose<List<Media>>((ref) async {
  final data = ref.watch(searchResultsProvider).value ?? [];
  return data.where((result) => result.type == MediaType.movie).toList();
});

final searchSeriesProvider =
    FutureProvider.autoDispose<List<Media>>((ref) async {
  final data = ref.watch(searchResultsProvider).value ?? [];
  return data.where((result) => result.type == MediaType.series).toList();
});

final mediaProvider = FutureProvider.family<Media, String>((ref, id) async {
  final Media media = Parser.media(await Fetcher.getMedia(id));
  return media;
});

final commentsProvider =
    FutureProvider.family<List<Comment>, String>((ref, id) async {
  return await FirestoreDatabase().getComments(id);
});

final inTheaters = FutureProvider.autoDispose<List<Media>>((ref) async {
  final data = await Fetcher.getMoviesInNearTheaters();
  return Parser.moviesInNearTheaters(data);
});

final trendingTrailers = FutureProvider.autoDispose<List<Media>>((ref) async {
  final data = await Fetcher.getTrendingTrailers();
  return Parser.trendingTrailers(data);
});