import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class AddButton extends StatelessWidget {
  final void Function() onPressed;
  final String? tooltip;
  final Color? buttonColor;
  final Color? borderColor;
  const AddButton({super.key, required this.onPressed, this.tooltip, this.buttonColor, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const HeroIcon(HeroIcons.plus),
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        side: MaterialStateProperty.all(
            BorderSide(
                color: borderColor ?? const Color.fromARGB(255, 221, 221, 221),
                width: 2
            ),
        ),
      ),
      tooltip: tooltip,
    );
  }
}
