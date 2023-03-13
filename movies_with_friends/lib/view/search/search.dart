import 'package:flutter/material.dart';
import 'package:movies_with_friends/view/search/widgets/search_result.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<SearchPage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Search',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SearchResult(poster: "https://m.media-amazon.com/images/I/61IaXLOWLDL._AC_UF894,1000_QL80_.jpg", title: "Million Dollar Arm", descritpion: "Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit velas qew fr."),
            SearchResult(poster: "https://m.media-amazon.com/images/M/MV5BMGQ0YWU4NjMtYjUyZC00ZWQyLTliYzEtOGE2NmJlMTUzZjU0XkEyXkFqcGdeQXVyMTA3MDk2NDg2._V1_.jpg", title: "Annette", descritpion: "Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit velas qew fr."),
            SearchResult(poster: "https://m.media-amazon.com/images/M/MV5BYzZkOGUwMzMtMTgyNS00YjFlLTg5NzYtZTE3Y2E5YTA5NWIyXkEyXkFqcGdeQXVyMjkwOTAyMDU@._V1_.jpg", title: "Black Adam", descritpion: "Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit velas qew fr.")
          ],
        ),
      ),
    );
  }
}
