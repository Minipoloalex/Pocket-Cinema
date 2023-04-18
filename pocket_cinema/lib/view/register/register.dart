import 'package:pocket_cinema/view/common_widgets/login_register_tabs.dart';
import 'package:pocket_cinema/view/common_widgets/input_field_login_register.dart';
import 'package:pocket_cinema/view/common_widgets/topbar_logo.dart';
import 'package:pocket_cinema/view/common_widgets/validate_lr.dart';
import 'package:pocket_cinema/view/common_widgets/password_form_field.dart';
import 'package:pocket_cinema/controller/authentication.dart';
import 'package:pocket_cinema/model/my_user.dart';
import 'package:flutter/material.dart';

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
                      key: const Key("emailField"),
                      hintText: "Email",
                      controller: _emailTextController
                  ),
                  TextFormFieldLoginRegister(
                    key: const Key("usernameField"),
                    hintText: "Username",
                    controller: _usernameTextController,
                  ),
                  PasswordFormField(
                    key: const Key("passwordRegisterField"),
                    hintText: 'Password',
                    passwordController: _passwordTextController,
                  ),
                  PasswordFormField(
                    key: const Key("confirmPasswordField"),
                    hintText: 'Confirm Password',
                    passwordController: _confirmPasswordTextController,
                  ),
                  ElevatedButton(
                    key: const Key("registerButton"),
                    onPressed: () {
                      final String? error = ValidateLR.validateRegister(
                          _usernameTextController.text,
                          _emailTextController.text,
                          _passwordTextController.text,
                          _confirmPasswordTextController.text);
                      if (error != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(error),
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 3),
                        ));
                      } else {
                        final user = MyUser(
                          username: _usernameTextController.text,
                          email: _emailTextController.text,
                        );
                        Authentication.createUser(
                          user
                        ).then((value) {
                          Navigator.pushNamed(context, '/');
                        }).onError((error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(error.toString()),
                            duration: const Duration(seconds: 3),
                          ));
                        });
                      }
                    },
                    child: const Text('Create account'),
                  ),
                ])));
  }
}