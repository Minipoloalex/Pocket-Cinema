import 'dart:convert';

import 'package:html/parser.dart';
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
            id: result["id"],
            name: result["l"],
            posterImage: result["i"]["imageUrl"] ?? "",
            description: result["s"] ?? "",
            type: result["qid"] == "tvSeries"
                ? MediaType.series
                : MediaType.movie))
        .toList();

    return mediaList;
  }

  static Media media(String body) {
    Map<String, dynamic> map = jsonDecode(body);

    final thumbnails = map["props"]["pageProps"]["aboveTheFoldData"]["primaryVideos"]["edges"];
    final thumbnail = thumbnails.isNotEmpty ? thumbnails[0]["node"]["thumbnail"]["url"] : "";

    return Media(
        id: map["props"]["pageProps"]["tconst"],
        name: map["props"]["pageProps"]["aboveTheFoldData"]["titleText"]["text"],
        posterImage: map["props"]["pageProps"]["aboveTheFoldData"]["primaryImage"]?["url"] ?? '',
        backgroundImage: thumbnail,
        rating: map["props"]["pageProps"]["aboveTheFoldData"]["ratingsSummary"]
                ["aggregateRating"]
            .toString(),
        nRatings: map["props"]["pageProps"]["aboveTheFoldData"]["ratingsSummary"]
                ["voteCount"]
            ,
        description: map["props"]["pageProps"]["aboveTheFoldData"]["plot"]["plotText"]
            ["plainText"],
        type: map["props"]["pageProps"]["aboveTheFoldData"]["titleType"]["id"] ==
                "movie"
            ? MediaType.movie
            : MediaType.series);
  }

  static List<Media> moviesInNearTheaters(String body) {
    final document = parse(body);
    final fatherDiv = document.querySelector('.lister-list');
    if (fatherDiv == null) {
      return throw Exception("No movies in near theaters found");
    }

    return fatherDiv.children
        .map((item) => Media(
              id: item.querySelector('img')?.attributes['data-tconst'] ?? "",
              posterImage:
                  item.querySelector('img')?.attributes['loadlate'] ?? "",
              name: item.querySelector('.title > a')?.text ?? "",
            ))
        .toList();
  }

  static List<Media> trendingTrailers(String body) {
    final document = parse(body);
    final fatherDiv = document.querySelector('.ipc-sub-grid');
    if (fatherDiv == null) return throw Exception("No trending trailers found");

    return fatherDiv.children
        .map((item) => Media(
              id: item
                      .querySelector('a.ipc-poster-card__title')
                      ?.attributes['href']
                      ?.split('/')[2] ??
                  "",
              name: item.querySelector('a.ipc-poster-card__title')?.text ?? "",
              posterImage:
                  item.querySelector('img.ipc-image')?.attributes['src'] ?? "",
              trailer: item
                      .querySelector('a.ipc-lockup-overlay')
                      ?.attributes['href'] ??
                  "",
              trailerDuration:
                  item.querySelector('span.ipc-lockup-overlay__text')?.text ??
                      "",
              releaseDate:
                  item.querySelector('.ipc-poster-card__actions > span')?.text,
            ))
        .toList();
  }

  static List movieTrailerPlaybacks(String body) {
    final document = parse(body);
    final script = document.querySelector('script#__NEXT_DATA__');
    if (script == null) {
      return throw Exception("No movie trailer playbacks found");
    }

    return jsonDecode(script.innerHtml)['props']['pageProps']
            ['videoPlaybackData']['video']['playbackURLs'] ??
        [];
  }
}
