import 'package:flutter/material.dart';
import 'package:pocket_cinema/view/common_widgets/horizontal_media_list.dart';
import 'package:pocket_cinema/model/media.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _MyLibraryPageState();
}

class _MyLibraryPageState extends State<LibraryPage> {

  static const List<Media> myMedia = [
    Media("Mad Men", "https://br.web.img3.acsta.net/pictures/21/02/10/20/02/0834301.jpg","assets/images/movieBackground.png","6/10","(12mil)","Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit vel, placerat ut lorem."),
    Media("Dr. House", "https://www.themoviedb.org/t/p/original/lW7MvZ4m49IUj2UrUu4z0xVVl81.jpg","assets/images/movieBackground.png","2/10","(12mil)","Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit vel, placerat ut lorem."),
    Media("Sherlock", "https://cdn.europosters.eu/image/750/posters/sherlock-destruction-i34921.jpg","assets/images/movieBackground.png","9/10","(12mil)","Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit vel, placerat ut lorem."),
    Media("The Walking Dead", "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/81UvZYUoOJL.jpg","assets/images/movieBackground.png","3/10","(12mil)","Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit vel, placerat ut lorem."),
    Media("Dexter", "https://cdn.europosters.eu/image/750/posters/dexter-shrinkwrapped-i14382.jpg","assets/images/movieBackground.png","6/10","(12mil)","Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit vel, placerat ut lorem."),
    Media("Patrick Melrose", "https://m.media-amazon.com/images/M/MV5BMjIwNzk4OTQ1NV5BMl5BanBnXkFtZTgwMjE0NDMyNTM@._V1_.jpg","assets/images/movieBackground.png","8/10","(12mil)","Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit vel, placerat ut lorem."),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Column(
          children: const <Widget>[
            HorizontalMediaList(
              name: "My First Series List!",
              media: myMedia
            )
          ],
        ),
      ),
    );
  }
}
