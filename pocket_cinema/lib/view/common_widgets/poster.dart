import 'package:flutter/material.dart';

class Poster extends StatelessWidget {
  final String name;
  final String url;

  const Poster(
      {super.key,
        required this.name,
        required this.url});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            width: 125,
            height: 187.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 125,
              child: Expanded(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2
                )
              )
            )
          )
        ]
    );
  }
}