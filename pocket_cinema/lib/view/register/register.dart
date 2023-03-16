import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {


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
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Username"),
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    }, 
                    child: const Text('Create account'),
                    ),
                ])));
  }
}
