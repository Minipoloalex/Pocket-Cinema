import 'dart:convert';

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/model/news.dart';

import 'api_key.dart';

class Fetcher {
  static Future searchMedia(String query) async {
    query = Uri.encodeComponent(query);
    final String url = "https://v3.sg.media-imdb.com/suggestion/x/$query.json";

    final response = await http.get(Uri.parse(url));
    return response.body;
  }

  static Future<Media> getMedia(String id) async {
    final String url = "https://www.imdb.com/title/$id/";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) throw Exception();
    var fullDoc = parse(response.body);
    var goodPart = fullDoc.querySelector("#__NEXT_DATA__")!.innerHtml;
    Map<String, dynamic> map = jsonDecode(goodPart);
    return Media(
        map["props"]["pageProps"]["tconst"],
        map["props"]["pageProps"]["aboveTheFoldData"]["titleText"]["text"],
        map["props"]["pageProps"]["aboveTheFoldData"]["primaryImage"]["url"],
        map["props"]["pageProps"]["aboveTheFoldData"]["primaryVideos"]["edges"]
            [0]["node"]["thumbnail"]["url"],
        map["props"]["pageProps"]["aboveTheFoldData"]["ratingsSummary"]
                ["aggregateRating"]
            .toString(),
        map["props"]["pageProps"]["aboveTheFoldData"]["ratingsSummary"]
                ["voteCount"]
            .toString(),
        map["props"]["pageProps"]["aboveTheFoldData"]["plot"]["plotText"]
            ["plainText"],
        map["props"]["pageProps"]["aboveTheFoldData"]["titleType"]["id"] ==
                "movie"
            ? MediaType.movie
            : MediaType.series);
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