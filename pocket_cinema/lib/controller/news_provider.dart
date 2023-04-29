import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/fetcher.dart';
import 'package:pocket_cinema/model/news.dart';

final newsProvider = FutureProvider.autoDispose<List<News>>((ref) async {
  return Fetcher.getNews();
});
