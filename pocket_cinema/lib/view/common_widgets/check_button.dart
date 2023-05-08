import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class CheckButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool initialChecked;
  const CheckButton({super.key,
  required this.initialChecked,
  required this.onPressed});

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  late bool checked = widget.initialChecked;

  @override
  Widget build(BuildContext context) {
    final Color checkedColor = Theme.of(context).colorScheme.primary;
    const Color whiteColor = Color.fromARGB(255, 221, 221, 221);

    return IconButton(
      icon: const HeroIcon(HeroIcons.check),
      onPressed: () {
        widget.onPressed();
        setState(() {
          checked = !checked;
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(checked ? checkedColor : null),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        side: MaterialStateProperty.all(
            BorderSide(color: checked ? checkedColor : whiteColor, width: 2)),
        )
      );
    }
}
