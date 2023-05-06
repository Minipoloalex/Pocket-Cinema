// stateless widget for horizontal media list shimmer
import 'package:flutter/material.dart';
import 'package:pocket_cinema/view/common_widgets/poster_shimmer.dart';

class HorizontalMediaListShimmer extends StatelessWidget {
  const HorizontalMediaListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const Divider(
            color: Colors.black,
          ),
          itemCount: 7,
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.all(8.0),
            child: PosterShimmer(),
          ),
        ));
  }
}
