import 'package:flutter/material.dart';

class DescriptionShimmer extends StatelessWidget {
  const DescriptionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
            3,
            (index) => Container(
                  height: 10,
                  margin: const EdgeInsets.only(bottom: 5),
                  color: Colors.black,
                )));
  }
}
