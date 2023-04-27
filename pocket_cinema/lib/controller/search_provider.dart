import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/fetcher.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:pocket_cinema/controller/parser.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/model/comment.dart';

final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

// Riverpod

final searchResultsProvider =
    FutureProvider.autoDispose<List<Media>>((ref) async {
  final searchQuery = ref.watch(searchQueryProvider);

  final String response = await Fetcher.searchMedia(searchQuery);
  return Parser.searchMedia(response);
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
  print("SOMETHING");
  return Parser.media(await Fetcher.getMedia(id));
});

//create a comments provider for the media
final commentsProvider =
    FutureProvider.family<List<Comment>, String>((ref, id) async {
  return await FirestoreDatabase.getComments(id);
});
