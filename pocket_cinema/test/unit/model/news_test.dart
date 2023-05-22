import 'package:intl/intl.dart';
import 'package:pocket_cinema/model/news.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const title = 'News title';
  const description = 'News description';
  const image = 'News image';
  const date = 'Mon, 12 Jul 2021 12:00:00 +0530';
  const link = 'News link';
  final Map<String, dynamic> newsJson = {
    'title': title,
    'description': description,
    'image': image,
    'date': date,
    'link': link,
  };
  test('News.fromJson', (){
    final News news = News.fromJson(newsJson);
    expect(news.title, title);
    expect(news.description, description);
    expect(news.image, image);
    expect(news.date, DateFormat('E, d MMM yyyy hh:mm:ss Z', 'en_US').parse(date));
    expect(news.link, link);
  });
}
