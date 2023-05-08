import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/model/media_list.dart';

final toWatchListProvider = FutureProvider<List<Media>>((ref) async {
  return await FirestoreDatabase.getPredefinedList("ToWatch");
});

// Return the lists of the user
final listsProvider = FutureProvider<List<MediaList>>((ref) async {
  return await FirestoreDatabase.getPersonalLists();
});

class WatchListNotifier extends StateNotifier<List<Media>> {
  WatchListNotifier() : super([]);

  void getWatchList() async {
    state = await FirestoreDatabase.getPredefinedList("watched");
  }

  void add(Media media) {
    state = [...state, media];
  }

  void remove(Media media) {
    state = state.where((element) => element.id != media.id).toList();
  }

  void toggle(Media media) async {
    if (state.contains(media)) {
      remove(media);
    } else {
      add(media);
    }

    await FirestoreDatabase.toggleMediaStatus(media, "watched");
    //TODO: reset the local action if some error occurs in FirestoreDatabase
  }
}

final watchListProvider = StateNotifierProvider<WatchListNotifier, List<Media>>((ref) {
  return WatchListNotifier();
});

