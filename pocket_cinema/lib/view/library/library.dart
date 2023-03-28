import 'package:flutter/material.dart';
import 'package:pocket_cinema/view/common_widgets/horizontal_media_list.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/view/library/widgets/list_button.dart';
import 'package:pocket_cinema/view/media_list/media_list.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key});

  @override
  State<LibraryPage> createState() => _MyLibraryPageState();
}

class _MyLibraryPageState extends State<LibraryPage> {
  static const List<Media> myMedia = [
    Media("Mad Men",
        "https://br.web.img3.acsta.net/pictures/21/02/10/20/02/0834301.jpg"),
    Media("Dr. House",
        "https://www.themoviedb.org/t/p/original/lW7MvZ4m49IUj2UrUu4z0xVVl81.jpg"),
    Media("Sherlock",
        "https://cdn.europosters.eu/image/750/posters/sherlock-destruction-i34921.jpg"),
    Media("The Walking Dead",
        "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/81UvZYUoOJL.jpg"),
    Media("Dexter",
        "https://cdn.europosters.eu/image/750/posters/dexter-shrinkwrapped-i14382.jpg"),
    Media("Patrick Melrose",
        "https://m.media-amazon.com/images/M/MV5BMjIwNzk4OTQ1NV5BMl5BanBnXkFtZTgwMjE0NDMyNTM@._V1_.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(height: 50),
          const HorizontalMediaList(
            name: "My First Series List!",
            media: myMedia,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListButton(
                icon: const HeroIcon(HeroIcons.checkCircle,
                    style: HeroIconStyle.solid),
                labelText: "Watched",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MediaListPage(
                              name: "Watched", mediaList: myMedia)));
                },
              ),
              const SizedBox(width: 20),
              ListButton(
                icon: const HeroIcon(HeroIcons.ellipsisHorizontalCircle,
                    style: HeroIconStyle.solid),
                labelText: "Watching",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MediaListPage(
                              name: "Watching", mediaList: myMedia)));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
