import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class AddButton extends StatelessWidget {
  final void Function() onPressed;
  final String? tooltip;
  final Color? buttonColor;
  final Color? borderColor;

  const AddButton({
    Key? key,
    required this.onPressed,
    this.tooltip,
    this.buttonColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? 'Add this movie/series to one of your lists',
      child: IconButton(
        icon: const HeroIcon(HeroIcons.plus),
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          side: borderColor != null
              ? MaterialStateProperty.all(
            BorderSide(
              color: borderColor ?? const Color.fromARGB(255, 221, 221, 221),
              width: 2,
            ),
          )
              : null,
        ),
      ),
    );
  }
}
