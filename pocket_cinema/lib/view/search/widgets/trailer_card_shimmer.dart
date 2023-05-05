import 'package:flutter/material.dart';

class TrailerCardShimmer extends StatelessWidget {
  const TrailerCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: double.infinity,
                  color: Colors.black,
                ),
                const SizedBox(height: 10),
                Container(
                  height: 16,
                  width: 150,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Container(
            width: 70,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(width: 15),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}
