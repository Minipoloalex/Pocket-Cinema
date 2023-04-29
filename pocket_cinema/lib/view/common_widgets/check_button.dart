import 'package:flutter/material.dart';

class CheckButton extends StatefulWidget {
  const CheckButton({super.key});

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  // bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    // final Color checkedColor = Theme.of(context).colorScheme.primary;
    // const Color whiteColor = Color.fromARGB(255, 221, 221, 221);
    return Container();
    /*
    return IconButton(
      icon: const HeroIcon(HeroIcons.check),
      onPressed: () {
        setState(() {
          _isChecked = !_isChecked;
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(_isChecked ? checkedColor : null),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        side: MaterialStateProperty.all(
            BorderSide(color: _isChecked ? checkedColor : whiteColor, width: 2)),
      ),
    );
     */
  }
}
