import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class WatchButtons extends StatelessWidget {
  const WatchButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final Color checkedColor = Theme.of(context).colorScheme.secondary;

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
    IconButton(
    icon: const HeroIcon(HeroIcons.check),
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const WatchButtons()),
    );
    },
    )
  },
  style: ButtonStyle(
  backgroundColor: MaterialStateProperty.all(_isWatched ? checkedColor : null),
  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
  side: MaterialStateProperty.all(
  BorderSide(color: checkedColor, width: 2)),
  ),
  ),
  IconButton(
  icon: const HeroIcon(HeroIcons.ellipsis-horizontal-e),
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const WatchButtons()),
  );
  style: ButtonStyle(
  backgroundColor: MaterialStateProperty.all(_isWatching ? checkedColor : null),
  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
  side: MaterialStateProperty.all(
  BorderSide(color: checkedColor, width: 2)),
  ),
  ),
  ],
  );
}
}