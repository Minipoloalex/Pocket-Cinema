import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/model/media_list.dart';

final toWatchListProvider = FutureProvider<List<Media>>((ref) async {
  return await FirestoreDatabase.getPredefinedList("ToWatch");
});

final watchedListProvider = FutureProvider<List<Media>>((ref) async {
  return await FirestoreDatabase.getPredefinedList("watched");
});

final listsProvider = FutureProvider<List<MediaList>>((ref) async {
  return await FirestoreDatabase.getPersonalLists();
});
