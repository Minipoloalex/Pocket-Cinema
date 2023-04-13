import 'package:flutter/material.dart';
import 'package:pocket_cinema/model/news.dart';

import '../../common_widgets/go_back_button.dart';

class NewsPage extends StatelessWidget {
  final News news;

  const NewsPage(
      {super.key,
      required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Transform.translate(
          offset: const Offset(10, 0),
          child: const GoBackButton(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        children: [
          Container(
            height: 350,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(60),
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
              image: DecorationImage(
                image: AssetImage(news.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news.description,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  news.date.toString(), //TODO: Format date
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  news.content,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
