import 'package:flutter/material.dart';

class SearchResultShimmer extends StatelessWidget {
  const SearchResultShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 150,
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
                  color: Colors.black,
                ),
                const SizedBox(height: 10),
                Container(
                  height: 60,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}