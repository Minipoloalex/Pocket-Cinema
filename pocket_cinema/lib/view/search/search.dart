import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:logger/logger.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/controller/search_provider.dart';
import 'package:pocket_cinema/view/common_widgets/error_widget.dart';
import 'package:pocket_cinema/view/common_widgets/horizontal_media_list.dart';
import 'package:pocket_cinema/view/common_widgets/horizontal_media_list_shimmer.dart';
import 'package:pocket_cinema/view/common_widgets/shimmer.dart';
import 'package:pocket_cinema/view/search/search_results_page.dart';
import 'package:pocket_cinema/view/search/widgets/trailer_card.dart';
import 'package:pocket_cinema/view/search/widgets/trailer_card_shimmer.dart';

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
    ref.read(watchListProvider.notifier).getWatchList();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();

    final inTheatersMedia = ref.watch(inTheaters);
    final trendingTrailersMedia = ref.watch(trendingTrailers);

    return Scaffold(
        body: Container(
      margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              key: const Key('searchField'),
              autofocus: false,
              focusNode: _searchFocusNode,
              onTap: () =>
                  Navigator.of(context).push(_searchResultsFadeTransition()),
              onSubmitted: (query) {},
              onChanged: (value) => {
                if (value.length > 2)
                  {ref.read(searchQueryProvider.notifier).state = value}
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: IconButton(
                    icon: const HeroIcon(HeroIcons.magnifyingGlass),
                    onPressed: () {
                      Navigator.of(context)
                          .push(_searchResultsFadeTransition());
                    },
                    key: const Key("searchButton"),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
            ),
          ),
          Column(
            children: [
              inTheatersMedia.when(
                  data: (data) =>
                      HorizontalMediaList(name: 'In Theaters', media: data),
                  loading: () =>
                      const ShimmerEffect(child: HorizontalMediaListShimmer()),
                  error: (error, stack) {
                    Logger().e(error);
                    return const ErrorOccurred();
                  })
            ],
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
              child: Text("Trending Trailers",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 30,
                  ))),
          Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Column(
                children: [
                  trendingTrailersMedia.when(
                    data: (data) => (Column(
                        children: data
                            .map((item) => TrailerCard(media: item))
                            .toList())),
                    error: (error, stack) {
                      Logger().e(error);
                      return const ErrorOccurred();
                    },
                    loading: () => ShimmerEffect(
                        child: Column(
                      children: List.generate(
                          4, (index) => const TrailerCardShimmer()),
                    )),
                  )
                ],
              )),
        ],
      ),
    ));
  }

  Route _searchResultsFadeTransition() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SearchResultsPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400));
  }
}
