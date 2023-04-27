import 'dart:convert';

import 'package:pocket_cinema/model/media.dart';

class Parser {
  static List<Media> searchMedia(String body) {
    Map<String, dynamic> map = jsonDecode(body);
    List searchResults = map["d"];

    // Only keep movies and series
    searchResults = searchResults
        .where(
            (result) => result["qid"] == "tvSeries" || result["qid"] == "movie")
        .toList();

    List<Media> mediaList = searchResults
        .map((result) => Media(
            result["id"],
            result["l"],
            result["i"]["imageUrl"] ?? "",
            "",
            "",
            "",
            result["s"] ?? "",
            result["qid"] == "tvSeries" ? MediaType.series : MediaType.movie))
        .toList();

    return mediaList;
  }

  static Media media(String body) {
    Map<String, dynamic> map = jsonDecode(body);

    final thumbnails = map["props"]["pageProps"]["aboveTheFoldData"]["primaryVideos"]["edges"];
    final thumbnail = thumbnails.isNotEmpty ? thumbnails[0]["node"]["thumbnail"]["url"] : "";

    return Media(
        map["props"]["pageProps"]["tconst"],
        map["props"]["pageProps"]["aboveTheFoldData"]["titleText"]["text"],
        map["props"]["pageProps"]["aboveTheFoldData"]["primaryImage"]["url"],
        thumbnail,
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
}
