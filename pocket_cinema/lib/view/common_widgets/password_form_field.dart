import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class PasswordFormField extends StatefulWidget {
  final String labelText;
  final TextEditingController passwordController;
  const PasswordFormField({super.key, required this.labelText, required this.passwordController});

  @override
  State<PasswordFormField> createState() => PasswordFormFieldState();
}

class PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscureText = true;
  void toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: IconButton(
          icon: HeroIcon(_obscureText ? HeroIcons.eye : HeroIcons.eyeSlash),
          onPressed: () {
            toggleObscureText();
          },
        ),
      ),
      controller: widget.passwordController,
    );
  }
}
