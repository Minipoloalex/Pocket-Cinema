import 'package:flutter/material.dart';

Widget testableWidget(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: child,
    )
  );
}