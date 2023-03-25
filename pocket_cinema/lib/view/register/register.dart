import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pocket_cinema/model/UserModel.dart';
import 'package:pocket_cinema/view/common_widgets/password_form_field.dart';
import 'package:pocket_cinema/view/common_widgets/login_register_tabs.dart';
import 'package:pocket_cinema/view/common_widgets/input_field_login_register.dart';

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
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Text("Pocket Cinema",
                        textScaleFactor: 3,
                      ),
                    ),
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
                      ).then((value) {
                        Navigator.pushNamed(context, '/');
                        final user = UserModel(
                          username: _usernameTextController.text,
                          email: _emailTextController.text,
                        );
                        createUser(user);
                      }).onError((error, stackTrace) {
                        _usernameTextController.clear();
                        _emailTextController.clear();
                        _passwordTextController.clear();
                        Text("Error ${error.toString()}");
                        print("Error ${error.toString()}");
                      });
                    },
                    child: const Text('Create account'),
                    ),
                ])));
  }
  Future createUser(UserModel user) async {
    // Reference to a document
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    user.id = docUser.id;
    // Create document and write data to Firebase
    await docUser.set(user.toJson());
  }
}
