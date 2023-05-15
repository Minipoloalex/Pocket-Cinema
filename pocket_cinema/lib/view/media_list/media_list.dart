import 'package:flutter/material.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/poster.dart';
import 'package:pocket_cinema/view/media/media_page.dart';

class MediaListPage extends StatelessWidget {
  final String name;
  final List<Media> mediaList;
  final String? listId;
  const MediaListPage(
      {Key? key,
      required this.name,
      required this.mediaList,
      this.listId
      })
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
                    FirestoreDatabase.deletePersonalList(listId);
                    deleted = true;
                    Navigator.of(context).pop();
                  },
                  child: const Text("Delete"),
                ),
              ],
            ));
    return deleted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(name),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            actions: <Widget>[
              Visibility(
                visible: listId != null,
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    if (listId != null) {
                      deleteList(context, listId!).then((value) => {
                        if (value) Navigator.of(context).pop()
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
                                  MediaPage(id: mediaList[index].id)));
                    },
                    child: Poster(
                      name: mediaList[index].name,
                      url: mediaList[index].posterImage,
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
