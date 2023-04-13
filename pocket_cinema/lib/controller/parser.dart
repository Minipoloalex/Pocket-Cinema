import 'dart:convert';

import 'package:pocket_cinema/model/media.dart';

class Parser{
  static List<Media> searchMedia(String body){
    Map<String, dynamic> map = jsonDecode(body);
    List searchResults = map["d"];

    // Only keep movies and series
    searchResults = searchResults.where((result) => result["qid"] == "tvSeries" || result["qid"] == "movie").toList();

    List<Media> mediaList = searchResults.map((result) => Media(
      result["id"],
      result["l"],
      result["i"]["imageUrl"] ?? "",
      "",
      "",
      "",
      result["s"] ?? "",
      result["qid"] == "tvSeries" ? MediaType.series : MediaType.movie
    )).toList();

    return mediaList;
  }
}