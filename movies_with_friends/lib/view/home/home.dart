import 'package:flutter/material.dart';
import 'package:movies_with_friends/view/home/news_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            NewsCard(
                img: "assets/images/idrisElba.png",
                date: "Fri, 10 Mar 2023 15:04",
                description:
                    "Idris Elba reveals if he’d be interested in playing a brand new character in James Gunn’s DCU"),
            NewsCard(
                img: "assets/images/turtle.png",
                date: "Fri, 10 Mar 2023 15:00",
                description:
                    "EENAGE MUTANT NINJA TURTLE: MUTANT MAYHEM Artist Talks About Its Cool Spider-Verse Style..."),
            NewsCard(
                img: "assets/images/jennaOrtega.png",
                date: "Fri, 10 Mar 2023 14:48",
                description:
                    "Wednesday's Jenna Ortega May Star in Beetlejuice 2"),
            NewsCard(
                img: "assets/images/dungeonsDragons.png",
                date: "Fri, 10 Mar 2023 14:09",
                description:
                    "Dungeons & Dragons: Honor Among Thieves' Directors on Helming The Role Playing Game"),
          ],
        ),
      ),
    );
  }
}
