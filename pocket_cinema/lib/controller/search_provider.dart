import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/fetcher.dart';
import 'package:pocket_cinema/controller/parser.dart';
import 'package:pocket_cinema/model/media.dart';

final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

final searchResultsProvider = FutureProvider.autoDispose<List<Media>>((ref) async {
  final searchQuery = ref.watch(searchQueryProvider);
    
  final String response = await Fetcher.searchMedia(searchQuery);
  return Parser.searchMedia(response);
});

final searchMoviesProvider = FutureProvider.autoDispose<List<Media>>((ref) async {
  final data = ref.watch(searchResultsProvider).value ?? [];
  return data.where((result) => result.type == MediaType.movie).toList();
});

final searchSeriesProvider = FutureProvider.autoDispose<List<Media>>((ref) async {
  final data = ref.watch(searchResultsProvider).value ?? [];
  return data.where((result) => result.type == MediaType.series).toList();
});

final mediaProvider = FutureProvider.family<Media, String>((ref, id) async {
  return await Fetcher.getMedia(id);
});

