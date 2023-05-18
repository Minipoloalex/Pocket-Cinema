import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class ListButton extends StatelessWidget {
  const ListButton({
    Key? key,
    required this.labelText,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  final String labelText;
  final VoidCallback onPressed;
  final HeroIcon icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(labelText,
        style: const TextStyle(fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        surfaceTintColor: Theme.of(context).colorScheme.tertiary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );}
}