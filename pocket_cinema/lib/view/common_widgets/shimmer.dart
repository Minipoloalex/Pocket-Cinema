import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  final Widget child;
  const ShimmerEffect({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
          period: const Duration(milliseconds: 1000),
          baseColor: Theme.of(context).highlightColor,
          highlightColor: Theme.of(context).colorScheme.onPrimary,
          child: child
      );
  }
}
