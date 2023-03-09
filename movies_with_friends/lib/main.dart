import 'package:flutter/material.dart';

import 'package:movies_with_friends/view/theme.dart';
import 'package:movies_with_friends/view/home/home.dart';
import 'package:movies_with_friends/view/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Application root
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies With Friends',
      theme: applicationTheme,
      home: const LoginPage(title: 'Movies With Friends'),
    );
  }
}