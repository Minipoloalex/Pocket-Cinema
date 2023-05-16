import 'package:flutter/material.dart';

class NoResultsFoundWidget extends StatelessWidget {
  const NoResultsFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset(
          'assets/images/no_results_found.png',
        ),
        const Padding(padding: EdgeInsets.only(bottom: 20),
        child: Center(
            child: Text(
          'No results found',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ))),
      ],
    );
  }
}
