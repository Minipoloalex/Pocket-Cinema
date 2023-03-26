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
      segments: const [
        ButtonSegment(value: LoginRegister.login, label: Text("Login")),
        ButtonSegment(value: LoginRegister.register, label: Text("Register")),
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