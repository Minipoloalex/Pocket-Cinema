import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/model/media_list.dart';
import 'package:pocket_cinema/view/media_list/media_list.dart';

class MediaListPoster extends StatelessWidget {
  final String name;
  final MediaList mediaList;
  final Media? media;

  const MediaListPoster(
      {Key? key, required this.name, required this.mediaList, this.media})
      : super(key: key);

  _onTap(BuildContext context) {
    if (media != null) {
      // Add to list and show a toast 
      FirestoreDatabase.addMediaToList(media!, mediaList.id).then((_) {
        Fluttertoast.showToast(
          msg: "${media!.name} was added to ${mediaList.name}",
          timeInSecForIosWeb: 1,
        );
      }).onError((error, stackTrace) {
        if (error.toString() == "Exception: Already added") {
          Fluttertoast.showToast(
            msg: "${media!.name} has already been added to ${mediaList.name}",
            timeInSecForIosWeb: 1,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Some error occur while adding ${media!.name} to ${mediaList.name}",
            timeInSecForIosWeb: 1,
          );
        }
      });
      FirestoreDatabase.addMediaToList(media!, mediaList.id);
    } else {
      // Open list
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            MediaListPage(name: mediaList.name, mediaList: mediaList.media),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _onTap(context),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (mediaList.media.length >= 2) ...[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  width: 157 / 2,
                  height: 117,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(mediaList.media[0].posterImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                  )),
              Container(
                width: 157 / 2,
                height: 117,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(mediaList.media[1].posterImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5))),
              )
            ]),
          ] else if (mediaList.media.length == 1) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 157 / 2,
                    height: 117,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(mediaList.media[0].posterImage),
                        fit: BoxFit.cover,
                        // alignment: Alignment.topCenter
                      ),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                    )),
                Container(
                    width: 157 / 2,
                    height: 117,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                    ),
                    child: const Center(
                      child: HeroIcon(HeroIcons.film, style : HeroIconStyle.solid),
                    )),
              ],
            ),
          ] else ...[
            Container(
                width: 157,
                height: 117,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: const Center(
                  child: HeroIcon(HeroIcons.film, style : HeroIconStyle.solid),
                )),
          ],
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: SizedBox(
                width: 157,
                child: Text(name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2)),
          )
        ]));
  }
}

class MediaListList extends StatelessWidget {
  final List<MediaList> mediaListList;
  final Media? media;

  const MediaListList({Key? key, required this.mediaListList, this.media})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final columnChildren = <Widget>[];
    final rows = (mediaListList.length / 2).ceil();

    for (int i = 0; i < rows; i++) {
      final rowChildren = <Widget>[];
      for (int j = 0; j < 2; j++) {
        final index = i * 2 + j;
        if (index < mediaListList.length) {
          rowChildren.add(
            MediaListPoster(
                name: mediaListList[index].name,
                mediaList: mediaListList[index],
                media: media),
          );
        }
      }
      columnChildren.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: rowChildren.length == 2
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.start,
          children: rowChildren
              .map((widget) => Padding(
                    padding: EdgeInsets.only(
                        top: 25.0, left: (rowChildren.length == 2) ? 0 : 25.0),
                    child: widget,
                  ))
              .toList(),
        ),
      );
    }

    return Column(
      children: columnChildren,
    );
  }
}
