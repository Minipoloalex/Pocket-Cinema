import 'package:flutter/material.dart';
import 'package:pocket_cinema/view/common_widgets/add_button.dart';

import '../../common_widgets/check_button.dart';
import '../../media/media_page.dart';

class SearchResult extends StatelessWidget {
  final String poster;
  final String title;
  final String descritpion;

  const SearchResult({super.key, required this.poster, required this.title, required this.descritpion});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MediaPage(
                          backgroundImage:
                          'assets/images/movieBackground.png',
                          cardImage: 'assets/images/movieCard.png',
                          title: "Million Dollar Arm",
                          rating: "8/10",
                          nRatings: "(24mil)",
                          description:
                          "Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit vel, placerat ut lorem.")));
            },
          child:Container(
            width: 100,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(poster),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  descritpion,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: const [
              CheckButton(),
              AddButton(),
            ],
          )
        ],
      ),
    );
  }
}