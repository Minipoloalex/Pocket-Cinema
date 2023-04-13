import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    const Color middleBlueColor = Color.fromARGB(255, 22, 33, 62);

    return IconButton(
      icon: const HeroIcon(HeroIcons.arrowLeft),
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
        backgroundColor: MaterialStateProperty.all(middleBlueColor),
      ),
    );
  }
}
