import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heroicons/heroicons.dart';

import 'package:pocket_cinema/controller/fetcher.dart';
import 'package:pocket_cinema/controller/parser.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/search/trailer_page.dart';

class PlayTrailerButton extends StatelessWidget {
  final Media media;
  const PlayTrailerButton({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: Key("playTrailer${key.toString()[key.toString().length - 1]}"),
      icon: const HeroIcon(HeroIcons.play, style: HeroIconStyle.solid),
      onPressed: () {
        if (media.trailer == null) {
          Fluttertoast.showToast(msg: "No trailer available");
          return;
        }
        Fetcher.getMovieTrailerPlaybacks(media.trailer!)
            .then((playbacksResponse) {
          final List playbacks =
              Parser.movieTrailerPlaybacks(playbacksResponse);
          if (playbacks.isEmpty) {
            Fluttertoast.showToast(msg: "No trailer available");
          }

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TrailerPage(
                      media: media, videoUrl: playbacks[0]['url'])));
        });
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.primary),
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(5)),
          iconColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.onPrimary)),
    );
  }
}
