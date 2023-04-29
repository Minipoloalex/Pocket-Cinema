import 'package:flutter/material.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/add_button.dart';
import 'package:pocket_cinema/view/common_widgets/check_button.dart';
import 'package:pocket_cinema/view/media/media_page.dart';


class SearchResult extends StatelessWidget {
  final Media media;

  const SearchResult({super.key, required this.media});

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
                      builder: (context) => MediaPage(id : media.id)));
            },
          child:Container(
            width: 100,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(media.posterImage),
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
                  media.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  media.description,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const CheckButton(),
              AddButton(
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}