import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    const Color whiteColor = Color.fromARGB(255, 221, 221, 221);

    return IconButton(
      icon: const HeroIcon(HeroIcons.plus),
      onPressed: () {},
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        side: MaterialStateProperty.all(
            const BorderSide(color: whiteColor, width: 2)),
      ),
    );
  }
}