import 'dart:convert';

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_cinema/model/news.dart';

import 'api_key.dart';

class Fetcher {
  static Future searchMedia(String query) async {
    query = Uri.encodeComponent(query);
    final String url = "https://v3.sg.media-imdb.com/suggestion/x/$query.json";

    final response = await http.get(Uri.parse(url));
    return response.body;
  }

  static Future<String> getMedia(String id) async {
    final String url = "https://www.imdb.com/title/$id/";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) throw Exception();
    var fullDoc = parse(response.body);
    return fullDoc.querySelector("#__NEXT_DATA__")!.innerHtml;
  }

  static Future<List<News>> getNews() async {
    final response = await http.get(
        Uri.parse('https://movies-news1.p.rapidapi.com/movies_news/recent'),
        headers: {
          'X-RapidAPI-Key':
          newsApiKey,
          'X-RapidAPI-Host': 'movies-news1.p.rapidapi.com'
        });
        const utf8Decoder = Utf8Decoder();
        final decodedResponse = utf8Decoder.convert(response.bodyBytes);
    if (response.statusCode != 200) throw Exception();
    List<dynamic> map = jsonDecode(decodedResponse);
    return map.map((news) => News.fromJson(news)).toList();
  }
} 