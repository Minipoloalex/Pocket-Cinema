import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/error_widget.dart';
import 'package:pocket_cinema/view/media_list/media_list_layout.dart';

class MediaListPage extends ConsumerWidget {
  final String name;
  final String? listId;
  final List<Media>? mediaList;
  final bool isToWatchProvider;
  final bool isWatchedProvider;

  const MediaListPage(
      {Key? key, required this.name, this.listId, this.mediaList, this.isToWatchProvider = false, this.isWatchedProvider = false})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watched List 
    if (isWatchedProvider) {
      final list = ref.watch(watchListProvider);
      return MediaListPageLayout(
        name: name,
        mediaList: list,
        listId: "watched",
        allowRemove: true,
        onDelete: () {
          ref.read(watchListProvider.notifier).getWatchList();
        }
      );
    }

    // To watch list
    if (isToWatchProvider) {
      final lists = ref.watch(toWatchListProvider);
      return lists.when(
          data: (data) => MediaListPageLayout(
                name: name,
                mediaList: data,
                listId: "toWatch",
                allowRemove: true,
                onDelete: () {
                  ref.refresh(toWatchListProvider).value;
                }
              ),
          loading: () => Container(),
          error: (error, stack) => ErrorOccurred(error: error));
    }

    // Fixed content
    if (mediaList != null) {
      return MediaListPageLayout(
        name: name,
        mediaList: mediaList!,
      );
    }

    // Personal list
    final lists = ref.watch(listsProvider);
    return lists.when(
        data: (data) => MediaListPageLayout(
              name: name,
              mediaList:
                  data.firstWhere((element) => element.id == listId).media,
              listId: listId,
              allowRemove: true,
              onDelete: () {
                ref.refresh(listsProvider).value;
              }
            ),
        loading: () => Container(),
        error: (error, stack) => ErrorOccurred(error: error));
  }
}
