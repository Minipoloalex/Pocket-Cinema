import 'package:flutter/material.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/poster.dart';

class MediaListPage extends StatelessWidget {
  final String name;
  final List<Media> mediaList;

  const MediaListPage({Key? key, required this.name, required this.mediaList}) : super(key: key);

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
                childAspectRatio: 0.45
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => Poster(
                  name: mediaList[index].name,
                  url: mediaList[index].url,
                ),
                childCount: mediaList.length,
              ),
            )),
        ],
      ),
    );
  }
}
