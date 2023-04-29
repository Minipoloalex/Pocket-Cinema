import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/controller/search_provider.dart';
import 'package:pocket_cinema/view/search/widgets/search_result.dart';
import 'package:pocket_cinema/view/search/widgets/search_result_shimmer.dart';
import 'package:pocket_cinema/view/search/widgets/no_results_found.dart';
import 'package:shimmer/shimmer.dart';

class SearchResultsPage extends ConsumerStatefulWidget {
  const SearchResultsPage({super.key});

  @override
  SearchPageResultsState createState() => SearchPageResultsState();
}

class SearchPageResultsState extends ConsumerState<SearchResultsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _searchController = TextEditingController(text: "");
  final _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(() {
        if(_searchController.text.length > 2){
          ref.read(searchQueryProvider.notifier).state = _searchController.text;
        }
    });
    _searchFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final movies = ref.watch(searchMoviesProvider);
    final series = ref.watch(searchSeriesProvider);

    return Scaffold(
        body: Container(
      margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
      child: 
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              onSubmitted: (query) {},
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: IconButton(
                    icon: const HeroIcon(HeroIcons.arrowLeft),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    icon: const HeroIcon(HeroIcons.xMark),
                    onPressed: () {
                      _searchController.clear();
                    },
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
          Flexible(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      movies.when(
                        data: (data) => data.isNotEmpty
                            ? ListView(
                          children: data
                              .map((e) => SearchResult(media: e))
                              .toList(),
                        )
                            : const NoResultsFoundWidget(),
                        loading: () => Shimmer.fromColors(
                          period: const Duration(milliseconds: 1000),
                          baseColor: Theme.of(context).highlightColor,
                          highlightColor: Theme.of(context).colorScheme.onPrimary,
                          child: ListView(
                            children: List.generate(3, (index) => const SearchResultShimmer()).toList(),
                          ),
                        ),
                        error: (error, stack) => Text(error.toString()),
                      ),
                      series.when(
                        data: (data) => data.isNotEmpty
                            ? ListView(
                          children: data
                              .map((e) => SearchResult(media: e))
                              .toList(),
                        )
                            : const NoResultsFoundWidget(),
                        loading: () => Shimmer.fromColors(
                          period: const Duration(milliseconds: 1000),
                          baseColor: Theme.of(context).highlightColor,
                          highlightColor: Theme.of(context).colorScheme.onPrimary,
                          child: ListView(
                            children: List.generate(3, (index) => const SearchResultShimmer()).toList(),
                          ),
                        ),
                        error: (error, stack) => Text(error.toString()),
                      ),
                    ],
                  )
              )
          )
        ],
      ),
    ));
  }
}
