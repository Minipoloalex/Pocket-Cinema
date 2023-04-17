import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pocket_cinema/controller/fetcher.dart';
import 'package:pocket_cinema/model/news.dart';

DateFormat format = DateFormat("E, dd MMM yyyy HH:mm:ss");

final newsProvider = FutureProvider.autoDispose<List<News>>((ref) async {
  return Fetcher.getNews();
});
