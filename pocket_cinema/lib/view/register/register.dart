import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _emailTextController = TextEditingController();
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
                  const Text("Pocket Cinema"),
                  SegmentedButton(
                    segments: const [
                       ButtonSegment(value: "login", label: Text("Login")),
                       ButtonSegment(value: "register", label: Text("Register")),
                    ],
                    selected: const <String>{"register"},
                    onSelectionChanged: (Set<String> newSelection) => {
                      if(newSelection.first == "login") {
                        Navigator.pushNamed(context, '/login')
                      }
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Email"), controller: _emailTextController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Username"),
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                    labelText: 'Password',
                    ),
                    controller: _passwordTextController,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _emailTextController .text,
                          password: _passwordTextController.text
                      ).then((value) {
                        Navigator.pushNamed(context, '/');
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                      });
                    }, 
                    child: const Text('Create account'),
                    ),
                ])));
  }
}
