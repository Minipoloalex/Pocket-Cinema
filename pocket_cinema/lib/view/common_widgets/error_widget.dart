import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class ErrorOccurred extends StatelessWidget {
  const ErrorOccurred({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25,),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            HeroIcon(HeroIcons.exclamationCircle),
            SizedBox(height: 8),
            Text("Some error occurred", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}