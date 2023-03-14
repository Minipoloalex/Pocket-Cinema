import 'package:flutter/material.dart';
import 'package:pocket_movies/model/media.dart';
import 'package:pocket_movies/view/common_widgets/poster.dart';

class MediaList extends StatelessWidget {
  final String name;
  final List<Media> media;

  const MediaList({super.key, required this.name, required this.media});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
            child: Text(
                name,
                textAlign: TextAlign.left
            )
          ),
          SizedBox(
              height: 300,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                itemCount: media.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Poster(
                    name: media[index].name,
                    url: media[index].url
                  ),
                ),
              )
          )
        ]
    );
  }
}
