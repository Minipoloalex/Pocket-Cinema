import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Poster extends StatelessWidget {
  final String name;
  final String url;

  const Poster({super.key, required this.name, required this.url});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 125,
        height: 187.5,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FadeInImage.memoryNetwork(
                    image: url, placeholder: kTransparentImage)
                .image,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      Flexible(
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  maxLines: 2)))
    ]);
  }
}
