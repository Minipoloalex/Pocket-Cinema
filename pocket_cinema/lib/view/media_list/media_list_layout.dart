import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/poster.dart';
import 'package:pocket_cinema/view/media/media_page.dart';

class MediaListPageLayout extends ConsumerWidget {
  final String name;
  final List<Media> mediaList;
  final String? listId;
  final bool allowRemove;
  final Function? onDelete;

  const MediaListPageLayout(
      {Key? key,
      required this.name,
      required this.mediaList,
      this.listId,
      this.allowRemove = false,
      this.onDelete})
      : super(key: key);

  Future<bool> deleteList(BuildContext context, String listId) async {
    bool deleted = false;
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Delete list"),
              content: const Text("Are you sure you want to delete this list?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    FirestoreDatabase().deletePersonalList(
                        listId, FirebaseAuth.instance.currentUser?.uid);
                    deleted = true;
                    Fluttertoast.showToast(msg: "Deleted list '$name'");
                    Navigator.of(context).pop();
                  },
                  child: const Text("Delete"),
                ),
              ],
            ));
    return deleted;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(name),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            actions: <Widget>[
              Visibility(
                visible: listId != null && listId != "watched" && listId != "toWatch",
                child: IconButton(
                  icon: const HeroIcon(HeroIcons.trash),
                  onPressed: () async {
                    if (listId != null && listId != "watched" && listId != "toWatch") {
                      deleteList(context, listId!).then((value) => {
                            if (value)
                              {
                                ref.refresh(listsProvider).value,
                                ref.refresh(toWatchListProvider).value,
                                Navigator.of(context).pop(),
                              },
                          });
                    }
                  },
                ),
              ),
            ],
          ),
          SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.45),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MediaPage(id: mediaList[index].id),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Poster(
                          name: mediaList[index].name,
                          url: mediaList[index].posterImage,
                        ),
                        if (allowRemove)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: const HeroIcon(HeroIcons.trash),
                              onPressed: () {
                                final mediaId = mediaList[index].id;
                                if (listId == "watched" ||
                                    listId == "toWatch") {
                                  FirestoreDatabase().removeMediaFromPredifinedList(
                                      Media(
                                          id: mediaId,
                                          name: "",
                                          posterImage: ""),
                                      listId!,
                                      FirebaseAuth.instance.currentUser?.uid);
                                } else {
                                  FirestoreDatabase().removeMediaFromList(
                                      mediaList[index].id, listId!);
                                }
                                Fluttertoast.showToast(
                                    msg: "Media removed from list");
                                onDelete?.call();
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                        Color?>(
                                    Theme.of(context).colorScheme.secondary),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  childCount: mediaList.length,
                ),
              )),
        ],
      ),
    );
  }
}
