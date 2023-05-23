import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/media/media_page.dart';
import 'package:pocket_cinema/view/common_widgets/play_trailer_button.dart';

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
                    image: FadeInImage(
                      placeholder:
                          const AssetImage('assets/images/placeholder.png'),
                      image: CachedNetworkImageProvider(media.posterImage),
                      fadeInDuration: const Duration(milliseconds: 500),
                      fadeOutDuration: const Duration(milliseconds: 500),
                      imageErrorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    ).image,
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
                child: PlayTrailerButton(
                    key: Key(
                        "playTrailer${key.toString()[key.toString().length - 1]}"),
                    backgroundColor: Theme.of(context).primaryColor,
                    media: media),
              ),
            ],
          ),
        ));
  }
}
