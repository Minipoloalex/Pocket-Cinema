import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pocket_cinema/controller/firestore_funcs.dart';
import 'package:pocket_cinema/view/common_widgets/password_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userIdTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  bool _obscureText = true;
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
                    decoration: const InputDecoration(labelText: "Email or Username"),
                    controller: _userIdTextController,
                  ),
                  PasswordFormField(
                    labelText: 'Password',
                    passwordController: _passwordTextController,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      signIn().then((value) {
                        Navigator.pushNamed(context, '/');
                      }).onError((error, stackTrace) {
                        print("Error: ${error.toString()}");
                      });
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
  Future signIn() async {
    final userId = _userIdTextController.text;
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: isEmail(userId) ? userId : await getEmail(userId).then((email) => email),
      password: _passwordTextController.text,
    ).onError((error, stackTrace) {
      throw("Error: ${error.toString()}");
    });
  }
}
