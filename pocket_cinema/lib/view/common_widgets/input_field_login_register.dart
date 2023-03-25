import 'package:flutter/material.dart';

class TextFormFieldLoginRegister extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  final IconButton? suffixIcon;
  final bool obscureText;

  const TextFormFieldLoginRegister({super.key,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    this.obscureText = false,
  });
  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          border: const OutlineInputBorder(),
          fillColor: Theme.of(context).colorScheme.onPrimary,
          filled: true,
          suffixIcon: suffixIcon,
        ),
        obscureText: obscureText,
        style: const TextStyle(
          color: Colors.black,
        ),
        controller: controller,
      )
    );
}
