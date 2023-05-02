import 'package:flutter/material.dart';
import 'package:pocket_cinema/model/news.dart';
import 'package:pocket_cinema/view/common_widgets/go_back_button.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatelessWidget {
  final News news;

  const NewsPage({super.key, required this.news});

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(news.link))) {
      //TODO: Snackbar error "Couldn't open the news page"
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Transform.translate(
          offset: const Offset(10, 0),
          child: const GoBackButton(key: Key('goBackButton')),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        children: [
          Container(
            height: 350,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
              image: DecorationImage(
                image: NetworkImage(news.image),
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
                  news.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  timeago.format(news.date),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  news.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Center(
                  heightFactor: 2,
                  child: ElevatedButton(
                    key: const Key('continueReadingButton'),
                    onPressed: _launchUrl,
                    child: const Text('Continue Reading'),
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
