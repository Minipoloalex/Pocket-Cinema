import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/controller/fetcher.dart';
import 'package:pocket_cinema/controller/parser.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/trailer_player.dart';
import 'package:pocket_cinema/view/media/media_page.dart';

class TrailerCard extends StatelessWidget {
  final Media media;

  const TrailerCard({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => MediaPage(id: media.id))),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(media.posterImage),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      media.name,
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Visibility(
                      visible: media.releaseDate != null,
                      child: Text(
                        media.releaseDate ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    media.trailerDuration ?? '',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: IconButton(
                    icon: const HeroIcon(HeroIcons.play,
                        style: HeroIconStyle.solid),
                    onPressed: () {
                      if (media.trailer == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("No trailer available")));
                        return;
                      }

                      Fetcher.getMovieTrailerPlaybacks(media.trailer!)
                          .then((playbacksResponse) {
                        final List playbacks =
                            Parser.movieTrailerPlaybacks(playbacksResponse);
                        if (playbacks.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("No trailer available")));
                          return;
                        }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TrailerPlayer(
                                    videoUrl: playbacks[0]['url'])));
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.primary),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(5)),
                        iconColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.onPrimary)),
                  )),
            ],
          ),
        ));
  }
}
