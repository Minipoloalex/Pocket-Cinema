import 'package:flutter/material.dart';

class NoResultsFoundWidget extends StatelessWidget {
  const NoResultsFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/no_results_found.png',
        ),
        const Text(
          'No results found',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}