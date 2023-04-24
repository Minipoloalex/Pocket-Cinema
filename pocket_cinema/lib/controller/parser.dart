import 'dart:convert';

import 'package:html/parser.dart';
import 'package:pocket_cinema/model/media.dart';

class Parser{
  static List<Media> searchMedia(String body){
    Map<String, dynamic> map = jsonDecode(body);
    List searchResults = map["d"];

    // Only keep movies and series
    searchResults = searchResults.where((result) => result["qid"] == "tvSeries" || result["qid"] == "movie").toList();

    List<Media> mediaList = searchResults.map((result) => Media(
      id: result["id"],
      name: result["l"],
      posterImage: result["i"]["imageUrl"] ?? "",
      description: result["s"] ?? "",
      type: result["qid"] == "tvSeries" ? MediaType.series : MediaType.movie
    )).toList();

    return mediaList;
  }

  static List<Media> featured(String className, String body){
    var fullDoc = parse(body);
    //get the good part of the html
    final fatherDiv = fullDoc.querySelector(".$className .ipc-sub-grid");
    if(fatherDiv == null) return throw Exception("No featured media found: $className");

    List<Media> mediaList = fatherDiv.children.map((e) => 
      Media(
        id: e.querySelector(".ipc-poster-card__title")!.attributes["href"]!.split("/")[2],
        name: e.querySelector(".ipc-poster-card__title > span")!.text,
        posterImage: e.querySelector(".ipc-image")!.attributes["src"]!,
        nRatings: e.querySelector(".ipc-rating-star")!.text,
      )).toList();

    return mediaList;
  }

  static List<Media> moviesInNearTheaters(String body){
    final document = parse(body);
    final fatherDiv = document.querySelector('.lister-list');
    if(fatherDiv == null) return throw Exception("No movies in near theaters found");

    List<Media> mediaList = fatherDiv.children.map((item) => 
      Media(
        id: item.querySelector('img')!.attributes['data-tconst']!,
        posterImage: item.querySelector('img')!.attributes['loadlate']!,
        name: item.querySelector('.title > a')!.text,
        rating: item.nextElementSibling!.querySelector(".ratings-imdb-rating")!.attributes['ratings-imdb-rating'],
      )
    ).toList();

    return mediaList;
  }
}