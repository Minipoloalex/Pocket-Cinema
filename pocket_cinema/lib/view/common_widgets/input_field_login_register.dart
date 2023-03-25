import 'package:flutter/material.dart';

class TextFormFieldLoginRegister extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const TextFormFieldLoginRegister({super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        border: const OutlineInputBorder(),
        fillColor: Theme.of(context).colorScheme.onPrimary,
        filled: true,
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
      controller: controller,
    );
}