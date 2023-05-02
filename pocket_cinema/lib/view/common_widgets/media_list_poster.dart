import 'package:flutter/material.dart';
import 'package:pocket_cinema/model/mediaList.dart';
import 'package:pocket_cinema/model/media.dart';

class MediaListPoster extends StatelessWidget {
  final String name;
  final MediaList mediaList;

  const MediaListPoster({
    Key? key,
    required this.name,
    required this.mediaList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildImage(Media media) => Container(
      width: 125,
      height: 187.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(media.posterImage),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
    );

    if (mediaList.media.length == 1) {
      return Column(
        children: [
          buildImage(mediaList.media[0]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 125,
              child: Expanded(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ),
        ],
      );
    } else if (mediaList.media.length >= 2) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: buildImage(mediaList.media[0])),
              SizedBox(width: 8),
              Expanded(child: buildImage(mediaList.media[1])),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 125,
              child: Expanded(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      // Return an empty container if there are no media items
      return Container();
    }
  }
}

