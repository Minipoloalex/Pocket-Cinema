

import 'package:flutter/material.dart';

import 'package:pocket_cinema/controller/authentication.dart';
import 'package:pocket_cinema/view/common_widgets/password_form_field.dart';
import 'package:pocket_cinema/view/common_widgets/login_register_tabs.dart';
import 'package:pocket_cinema/view/common_widgets/input_field_login_register.dart';
import 'package:pocket_cinema/view/common_widgets/topbar_logo.dart';

import 'package:pocket_cinema/model/my_user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userIdTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TopBarLogo(),
                    const LoginRegisterSegmentedButton(selectedPage: LoginRegister.login),
                    TextFormFieldLoginRegister(
                        key: const Key("userIdField"),
                        hintText: 'Email or Username',
                        controller: _userIdTextController,
                    ),
                  PasswordFormField(
                    key: const Key("passwordLoginField"),
                    hintText: 'Password',
                    passwordController: _passwordTextController,
                  ),
                  ElevatedButton(
                    key: const Key("LoginButton"),
                    onPressed: () {
                      Authentication.signIn(_userIdTextController, _passwordTextController).then((value) {
                        Navigator.pushNamed(context, '/');
                      }).onError((error, stackTrace) {
                        print("Error: ${error.toString()}");
                      });
                    },
                    child: const Text('Login'),
                    ),
                    const Divider(),
                  ElevatedButton(
                  onPressed: () {
                    Authentication.signInWithGoogle().then((user) {
                      if (user == null || user.displayName == null || user.email == null) return;
                      Authentication.createUserGoogleSignIn(
                        MyUser(username: user.displayName, email: user.email),
                      );
                      Navigator.pushNamed(context, '/');
                    }).onError((error, stackTrace) {
                      throw("Error: ${error.toString()}");
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Login with Google')),
                  ]
                )
        )
    );
  }
}
