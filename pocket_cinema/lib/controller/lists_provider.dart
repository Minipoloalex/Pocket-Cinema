import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/model/media_list.dart';

final toWatchListProvider = FutureProvider<List<Media>>((ref) async {
  return await FirestoreDatabase().getPredefinedList("toWatch", FirebaseAuth.instance.currentUser?.uid);
});

final listsProvider = FutureProvider<List<MediaList>>((ref) async {
  return await FirestoreDatabase().getPersonalLists(FirebaseAuth.instance.currentUser?.uid);
});


class WatchListNotifier extends StateNotifier<List<Media>> {
  WatchListNotifier() : super([]);

  void getWatchList() async {
    state = await FirestoreDatabase().getPredefinedList("watched", FirebaseAuth.instance.currentUser?.uid);
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

    try{
      await FirestoreDatabase().toggleMediaStatus(media, "watched", FirebaseAuth.instance.currentUser?.uid);
    }catch(e){
      if (state.contains(media)) {
        remove(media);
      } else {
        add(media);
      }
    }
  }
}

final watchListProvider = StateNotifierProvider<WatchListNotifier, List<Media>>((ref) {
  return WatchListNotifier();
});
