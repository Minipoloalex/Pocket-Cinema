import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
                    selected: const <String>{"login"},
                    onSelectionChanged: (Set<String> newSelection) => {
                      if(newSelection.first == "register") {
                        Navigator.pushNamed(context, '/register')
                      }
                    },
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    }, 
                    child: const Text('Login'),
                    ),
                    const Divider(),
                  ElevatedButton(
                  onPressed: () {}, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Login with Google')),
                ])));
  }
}
