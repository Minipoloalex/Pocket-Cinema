import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/view/common_widgets/input_field_login_register.dart';

class PasswordFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController passwordController;
  const PasswordFormField({super.key, required this.hintText, required this.passwordController});

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
  Widget build(BuildContext context) => TextFormFieldLoginRegister(
      hintText: widget.hintText,
      controller: widget.passwordController,
      suffixIcon: IconButton(
        icon: HeroIcon(_obscureText ? HeroIcons.eye : HeroIcons.eyeSlash),
        onPressed: () {
          toggleObscureText();
        },
      ),
      obscureText: _obscureText,
    );
      /*
      TextFormField(
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
       */
}
