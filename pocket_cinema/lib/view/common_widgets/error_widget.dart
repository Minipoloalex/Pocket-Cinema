import 'dart:io';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class ErrorOccurred extends StatelessWidget {
  final Object error;
  final StackTrace? stackTrace;
  const ErrorOccurred({super.key, required this.error, this.stackTrace});

  @override
  Widget build(BuildContext context) {
    final internetError = error is SocketException;
    final icon = internetError ? HeroIcons.exclamationCircle : HeroIcons.exclamationCircle;
    final text = internetError ? "Network error, check your network status." : "Some error occurred";

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeroIcon(icon),
            const SizedBox(height: 8),
            Text(text, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
