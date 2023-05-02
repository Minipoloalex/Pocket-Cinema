import 'package:flutter/material.dart';
import 'package:pocket_cinema/model/mediaList.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/poster_shimmer.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';

class MediaListPoster extends StatelessWidget {
  final String name;
  final MediaList mediaList;

  const MediaListPoster({Key? key, required this.name, required this.mediaList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (mediaList.media.length >= 2) ...[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
          ],
        ), /*  */
      ] else if (mediaList.media.length == 1) ...[
        Container(
            width: 157,
            height: 117,
            decoration: BoxDecoration(
              image: DecorationImage(
                /*  */
                image: NetworkImage(mediaList.media[0].posterImage),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(5.0),
            )),
      ] else ...[
        const Image(
          image: AssetImage('assets/images/defaultListImage.png'),
          height: 117,
        ),
      ],
      Text(name),
    ]);
  }
}

class MediaListList extends StatelessWidget {
  final List<MediaList> mediaListList;

  const MediaListList({Key? key, required this.mediaListList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // This will display 2 items per row
      children: List.generate(mediaListList.length, (index) {
        return Center(
          child: MediaListPoster(
            name: mediaListList[index].name,
            mediaList: mediaListList[index],
          ),
        );
      }),
    );
  }
}
