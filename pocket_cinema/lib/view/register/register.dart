import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pocket_cinema/controller/authentication.dart';
import 'package:pocket_cinema/model/my_user.dart';
import 'package:pocket_cinema/view/common_widgets/password_form_field.dart';
import 'package:pocket_cinema/view/common_widgets/login_register_tabs.dart';
import 'package:pocket_cinema/view/common_widgets/input_field_login_register.dart';
import 'package:pocket_cinema/view/common_widgets/topbar_logo.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController = TextEditingController();

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
                    const LoginRegisterSegmentedButton(selectedPage: LoginRegister.register),
                  TextFormFieldLoginRegister(
                      hintText: "Email",
                      controller: _emailTextController
                  ),
                  TextFormFieldLoginRegister(
                    hintText: "Username",
                    controller: _usernameTextController,
                  ),
                  PasswordFormField(
                    hintText: 'Password',
                    passwordController: _passwordTextController,
                  ),
                  PasswordFormField(
                    hintText: 'Confirm Password',
                    passwordController: _confirmPasswordTextController,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text,
                      ).then((value) async {
                        await value.user?.updateDisplayName(_usernameTextController.text);

                        Navigator.pushNamed(context, '/');
                        final user = MyUser(
                          username: _usernameTextController.text,
                          email: _emailTextController.text,
                        );
                        Authentication.createUser(user);
                      }).onError((error, stackTrace) {
                        _usernameTextController.clear();
                        _emailTextController.clear();
                        _passwordTextController.clear();
                        _confirmPasswordTextController.clear();
                        Text("Error ${error.toString()}");
                        print("Error ${error.toString()}");
                      });
                    },
                    child: const Text('Create account'),
                    ),
                ])));
  }
}
