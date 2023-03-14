import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:movies_with_friends/view/search/widgets/search_result.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onSubmitted: (String query) {},
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: IconButton(
                    icon: const HeroIcon(HeroIcons.arrowLeft),
                    onPressed: () {},
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    icon: const HeroIcon(HeroIcons.magnifyingGlass),
                    onPressed: () {},
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Movies'),
              Tab(text: 'Series'),
            ],
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: const <Widget>[
                          SearchResult(
                              poster:
                                  "https://m.media-amazon.com/images/I/61IaXLOWLDL._AC_UF894,1000_QL80_.jpg",
                              title: "Million Dollar Arm",
                              descritpion:
                                  "Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit velas qew fr."),
                          SearchResult(
                              poster:
                                  "https://m.media-amazon.com/images/M/MV5BMGQ0YWU4NjMtYjUyZC00ZWQyLTliYzEtOGE2NmJlMTUzZjU0XkEyXkFqcGdeQXVyMTA3MDk2NDg2._V1_.jpg",
                              title: "Annette",
                              descritpion:
                                  "Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit velas qew fr."),
                          SearchResult(
                              poster:
                                  "https://m.media-amazon.com/images/M/MV5BYzZkOGUwMzMtMTgyNS00YjFlLTg5NzYtZTE3Y2E5YTA5NWIyXkEyXkFqcGdeQXVyMjkwOTAyMDU@._V1_.jpg",
                              title: "Black Adam",
                              descritpion:
                                  "Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit velas qew fr.")
                        ],
                      ),
                      Column(
                        children: const <Widget>[
                          SearchResult(
                              poster:
                                  "https://br.web.img3.acsta.net/pictures/21/02/10/20/02/0834301.jpg",
                              title: "Mad Men",
                              descritpion:
                                  "Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit velas qew fr."),
                          SearchResult(
                              poster:
                                  "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/81UvZYUoOJL.jpg",
                              title: "The Walking Dead",
                              descritpion:
                                  "Etiam mattis convallis orci eu malesuada. Donec odio ex, facilisis ac blandit velas qew fr."),
                        ],
                      ),
                    ],
                  )))
        ],
      ),
    ));
  }
}
