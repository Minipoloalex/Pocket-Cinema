
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/model/media.dart';

const _movies = [
  Media("Million Dollar Arm", "https://m.media-amazon.com/images/I/61IaXLOWLDL._AC_UF894,1000_QL80_.jpg", description: "Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit velas qew fr."),
  Media("Annette", "https://m.media-amazon.com/images/M/MV5BMGQ0YWU4NjMtYjUyZC00ZWQyLTliYzEtOGE2NmJlMTUzZjU0XkEyXkFqcGdeQXVyMTA3MDk2NDg2._V1_.jpg", description: "Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit velas qew fr."),
  Media("Black Adam", "https://m.media-amazon.com/images/M/MV5BYzZkOGUwMzMtMTgyNS00YjFlLTg5NzYtZTE3Y2E5YTA5NWIyXkEyXkFqcGdeQXVyMjkwOTAyMDU@._V1_.jpg", description: "Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit velas qew fr.")
];

const _shows = [
  Media("Mad Men", "https://br.web.img3.acsta.net/pictures/21/02/10/20/02/0834301.jpg", description: "Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit velas qew fr."),
  Media("The Walking Dead", "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/81UvZYUoOJL.jpg", description: "Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit velas qew fr."),
];

enum SearchType {
  movies,
  shows,
}

final searchTypeProvider = StateProvider<SearchType>(
  (ref) => SearchType.movies,
);

//search provider that returns a list of media objects given a query
final searchResultsProvider = FutureProvider.autoDispose<List<Media>>((ref) async {
  final searchType = ref.watch(searchTypeProvider);
  switch (searchType) {
    case SearchType.movies:
      return _movies;
    case SearchType.shows:
      return _shows;
  }
});

final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');
