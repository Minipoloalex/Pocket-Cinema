import 'package:flutter/material.dart';
import 'package:movies_with_friends/view/home/widgets/news_page.dart';

class NewsCard extends StatelessWidget {
  final String date;
  final String img;
  final String description;
  final String content;

  const NewsCard(
      {super.key,
      required this.img,
      required this.date,
      required this.description,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsPage(
                          img: img,
                          date: date,
                          description: description,
                          content: content)));
            },
            borderRadius: BorderRadius.circular(15),
            child: Card(
              margin: EdgeInsets.zero,
              color: Theme.of(context).cardColor,
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 15.0, 10.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(img),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  height: 115,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(description),
                          Text(date),
                        ],
                      )),
                )),
              ]),
            )));
  }
}
