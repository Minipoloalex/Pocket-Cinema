import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/model/media.dart';
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
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MediaPage(id: media.id)));
            },
            child: Container(
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
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  media.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(media.releaseDate ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                    ))
              ],
            ),
          ),
          Text(
            media.trailerDuration ?? '',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: IconButton(
                icon:
                    const HeroIcon(HeroIcons.play, style: HeroIconStyle.solid),
                onPressed: () {},
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
    );
  }
}
