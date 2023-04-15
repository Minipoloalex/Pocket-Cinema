import 'package:flutter/material.dart';

enum LoginRegister{
  login,
  register,
}

class LoginRegisterSegmentedButton extends StatelessWidget {
  final LoginRegister selectedPage;
  const LoginRegisterSegmentedButton({super.key, required this.selectedPage});

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(vertical: 20.0),
    child: SegmentedButton(
      key: const Key("loginRegisterTabs"),
      segments: const [
        ButtonSegment(value: LoginRegister.login, label: Text(key: Key("loginTab"), "Login")),
        ButtonSegment(value: LoginRegister.register, label: Text(key: Key("registerTab"), "Register")),
      ],
      showSelectedIcon: false,
      selected: <LoginRegister>{ selectedPage },
      onSelectionChanged: (Set<LoginRegister> newSelection) => {
        if(newSelection.first != selectedPage) {
          Navigator.pushNamed(context, selectedPage == LoginRegister.login ? "/register" : "/login")
        }
      },
    )
  );
}