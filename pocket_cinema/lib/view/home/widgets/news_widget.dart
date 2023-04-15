import 'package:flutter/material.dart';
import 'package:pocket_cinema/model/news.dart';
import 'package:pocket_cinema/view/home/widgets/news_page.dart';

class NewsCard extends StatelessWidget {
  final News news;

  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsPage(news: news)));
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
                          image: NetworkImage(news.image),
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
                          Text(news.title),
                          Text(news.date.toString()), //TODO: Format date
                        ],
                      )),
                )),
              ]),
            )));
  }
}
