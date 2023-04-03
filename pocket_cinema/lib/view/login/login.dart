import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';

import 'package:pocket_cinema/controller/firestore_funcs.dart';
import 'package:pocket_cinema/view/common_widgets/password_form_field.dart';
import 'package:pocket_cinema/view/common_widgets/login_register_tabs.dart';
import 'package:pocket_cinema/view/common_widgets/input_field_login_register.dart';
import 'package:pocket_cinema/model/user_model.dart';


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
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Text("Pocket Cinema",
                        textScaleFactor: 3,
                      ),
                    ),
                    const LoginRegisterSegmentedButton(selectedPage: LoginRegister.login),
                    TextFormFieldLoginRegister(
                        hintText: 'Email or Username',
                        controller: _userIdTextController,
                    ),
                  PasswordFormField(
                    hintText: 'Password',
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
                  onPressed: () {
                    signInWithGoogle().then((user) {
                      if (user == null || user.displayName == null || user.email == null) return;
                      createUserGoogleSignIn(
                          UserModel(username: user.displayName, email: user.email),
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
  Future signIn() async {
    final userId = _userIdTextController.text;
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: isEmail(userId) ? userId : await getEmail(userId).then((email) => email),
      password: _passwordTextController.text,
    ).onError((error, stackTrace) {
      throw("Error: ${error.toString()}");
    });
  }

  Future<User?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ),
        );
        return userCredential.user;
      }
    }
    throw FirebaseAuthException(
      message: "Sign in aborted by user",
      code: "ERROR_ABORTED_BY_USER",
    );
  }
  Future createUserGoogleSignIn(UserModel user) async {
    if (await notExistsUser(user)) {
      // Reference to a document
      final docUser = FirebaseFirestore.instance.collection('users').doc();
      user.id = docUser.id;
      // Create document and write data to Firebase
      await docUser.set(user.toJson());
    }
  }
  Future<bool> notExistsUser(UserModel user) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users')
        .where("username", isEqualTo: user.username)
        .where("email", isEqualTo: user.email)
      .get();
    return snapshot.docs.isEmpty;
  }
}
