import 'package:flutter/material.dart';
import 'package:pocket_cinema/model/news.dart';
import 'package:pocket_cinema/view/home/widgets/news_page.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:pocket_cinema/view/common_widgets/string_capitalize.dart';
import 'package:transparent_image/transparent_image.dart';

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
                          image: FadeInImage.memoryNetwork(image: news.image, placeholder: kTransparentImage).image,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
                    child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                news.title,
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                              ),
                            Text(timeago.format(news.date).capitalize()),
                          ],
                        )),
                ),
              ]),
            )));
  }
}
