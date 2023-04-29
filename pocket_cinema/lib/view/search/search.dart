import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/controller/search_provider.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/horizontal_media_list.dart';
import 'package:pocket_cinema/view/search/widgets/search_results_page.dart';
import 'package:pocket_cinema/view/search/widgets/trailer_card.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  MySearchPageState createState() => MySearchPageState();
}

class MySearchPageState extends ConsumerState<SearchPage>
    with SingleTickerProviderStateMixin {
  final _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    final inTheatersMedia = ref.watch(inTheaters);

    return Scaffold(
        body: Container(
      margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              autofocus: false,
              focusNode: _searchFocusNode,
              onTap: () => Navigator.of(context).push(_searchResultsFadeTransition()),
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
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
          Flexible(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Column(
                    children: [
                      inTheatersMedia.when(
                        data: (data) => HorizontalMediaList(
                            name: 'In Theaters', media: data),
                        //TODO: Add a shimmer effect
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, stack) {
                          print(error);
                          return const Center(
                            child: Text('Error'),
                          );
                        },
                      )
                    ],
                  ))),
          Flexible(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Column(
                    children: [
                      TrailerCard(media: Media(
                        id: "",
                        name: "Class of '09",
                        posterImage: "https://m.media-amazon.com/images/M/MV5BZDdkNjIyY2YtZTc3My00MDY1LThlNGEtYjExMWYzY2ViYWMyXkEyXkFqcGdeQXVyOTM4MTIwNTA@._V1_QL75_UY281_CR18,0,190,281_.jpg",
                        trailerDuration: "2:10",
                        releaseDate: "May 10, 2023"
                      ),)
                    ],
                  ))),
        ],
      ),
    ));
  }

  Route _searchResultsFadeTransition() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SearchResultsPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child){
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400)
    );
  }
}
