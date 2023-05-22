import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Poster extends StatelessWidget {
  final String name;
  final String url;

  const Poster({super.key, required this.name, required this.url});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Column(children: [
        Container(
          width: 125,
          height: 187.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FadeInImage(
                placeholder: const AssetImage('assets/images/placeholder.png'),
                image: CachedNetworkImageProvider(url),
                fadeInDuration: const Duration(milliseconds: 500),
                fadeOutDuration: const Duration(milliseconds: 500),
                imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
              ).image,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Flexible(
            child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2)
            )
        )
      ]),
    );
  }
}
