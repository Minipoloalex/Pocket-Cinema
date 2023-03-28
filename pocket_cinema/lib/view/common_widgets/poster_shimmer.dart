import 'package:flutter/material.dart';

class PosterShimmer extends StatelessWidget {
  const PosterShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 125,
        height: 187.5,
        color: Colors.black,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 10,
          width: 100,
          color: Colors.black,
        ),
      ),
    ]);
  }
}
