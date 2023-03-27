import 'package:flutter/material.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/poster.dart';
import 'package:pocket_cinema/view/media/media_page.dart';

class MediaListPage extends StatelessWidget {
  final String name;
  final List<Media> mediaList;

  const MediaListPage({Key? key, required this.name, required this.mediaList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(name),
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
                  (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MediaPage(media : mediaList[index])));
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
