import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pocket_cinema/model/UserModel.dart';
import 'package:pocket_cinema/view/common_widgets/password_form_field.dart';
import 'package:pocket_cinema/view/theme.dart';

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
                  const Text("Pocket Cinema"),
                  SegmentedButton(
                    segments: const [
                       ButtonSegment(value: "login", label: Text("Login")),
                       ButtonSegment(value: "register", label: Text("Register")),
                    ],
                    showSelectedIcon: false,
                    style: applicationTheme.segmentedButtonTheme.style,
                    selected: const <String>{"register"},
                    onSelectionChanged: (Set<String> newSelection) => {
                      if(newSelection.first == "login") {
                        Navigator.pushNamed(context, '/login')
                      }
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Email"),
                    controller: _emailTextController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Username"),
                    controller: _usernameTextController,
                  ),
                  PasswordFormField(
                    labelText: 'Password',
                    passwordController: _passwordTextController,
                  ),
                  PasswordFormField(
                    labelText: 'Confirm Password',
                    passwordController: _confirmPasswordTextController,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text

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
