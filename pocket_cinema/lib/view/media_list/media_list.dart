import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/media_list/media_list_layout.dart';

class MediaListPage extends ConsumerWidget {
  final String name;
  final String? listId;
  final List<Media>? mediaList;
  const MediaListPage(
      {Key? key, required this.name, this.listId, this.mediaList})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (mediaList != null) {
      return MediaListPageLayout(
        name: name,
        mediaList: mediaList!,
      );
    }

    if (listId == null) {
      final list = ref.watch(watchListProvider);
      return MediaListPageLayout(
        name: name,
        mediaList: list,
      );
    }

    final lists = ref.watch(listsProvider);
    return lists.when(
        data: (data) => MediaListPageLayout(
              name: name,
              mediaList:
                  data.firstWhere((element) => element.id == listId).media,
              listId: listId,
            ),
        loading: () => const Text("loading"),
        error: (error, stack) => const Text("error"));
  }
}
