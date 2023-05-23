import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heroicons/heroicons.dart';

import 'package:pocket_cinema/controller/fetcher.dart';
import 'package:pocket_cinema/controller/parser.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/search/trailer_page.dart';

class PlayTrailerButton extends StatelessWidget {
  final Media media;
  final Color? backgroundColor;
  final Color? borderColor;
  const PlayTrailerButton(
      {super.key, required this.media, this.backgroundColor, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: Key("playTrailer${key.toString()[key.toString().length - 1]}"),
      icon: const HeroIcon(HeroIcons.play, style: HeroIconStyle.solid),
      tooltip: "Play trailer",
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
          side: borderColor != null
              ? MaterialStateProperty.all(BorderSide(
                  color:
                      borderColor ?? const Color.fromARGB(255, 221, 221, 221),
                  width: 2,
                ))
              : null,
          backgroundColor: MaterialStateProperty.all<Color?>(backgroundColor),
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(5)),
          iconColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.onPrimary)),
    );
  }
}
