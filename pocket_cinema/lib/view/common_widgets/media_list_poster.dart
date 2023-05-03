import 'package:flutter/material.dart';
import 'package:pocket_cinema/model/media_list.dart';

class MediaListPoster extends StatelessWidget {
  final String name;
  final MediaList mediaList;

  const MediaListPoster({Key? key, required this.name, required this.mediaList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                  image: DecorationImage(
                    image: AssetImage('assets/images/halfDefaultListImage.png'),
                  ),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                )),
          ],
        ),
      ] else ...[
        const Image(
          image: AssetImage('assets/images/defaultListImage.png'),
          width: 157,
          height: 117,
        ),
      ],
      Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: SizedBox(
            width: 157,
            child: Expanded(
                child: Text(name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2))),
      )
    ]);
  }
}

class MediaListList extends StatelessWidget {
  final List<MediaList> mediaListList;

  const MediaListList({Key? key, required this.mediaListList})
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
                  mediaList: mediaListList[index]
              ),
          );
        }
      }
      columnChildren.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: rowChildren.length == 2 ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.start,
          children: rowChildren.map((widget) => Padding(
            padding: EdgeInsets.only(top: 25.0, left: (rowChildren.length == 2) ? 0 : 25.0),
            child: widget,
          )
          ).toList(),
        ),
      );
    }

    return Column(
      children: columnChildren,
    );
  }
}
