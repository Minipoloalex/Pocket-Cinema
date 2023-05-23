import 'package:flutter/material.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/poster.dart';
import 'package:pocket_cinema/view/media_list/media_list.dart';

class HorizontalMediaList extends StatelessWidget {
  final String name;
  final List<Media> media;

  const HorizontalMediaList(
      {super.key, required this.name, required this.media});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MediaListPage(name: name, mediaList: media))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              child: Text(name, textAlign: TextAlign.left, style: const TextStyle(fontSize: 30, ))),
          SizedBox(
              height: 300,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                itemCount: media.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Poster(name: media[index].name, url: media[index].posterImage),
                ),
              ))
        ]));
  }
}
