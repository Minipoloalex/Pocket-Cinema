import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/controller/search_provider.dart';
import 'package:pocket_cinema/view/search/widgets/search_result.dart';
import 'package:pocket_cinema/view/search/widgets/search_result_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  MySearchPageState createState() => MySearchPageState();
}

class MySearchPageState extends ConsumerState<SearchPage>
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
              onSubmitted: (query) {},
              onChanged: (value) => {
                if(value.length > 2){
                  ref.read(searchQueryProvider.notifier).state = value
                }
              },
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
          Flexible(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      movies.when(
                        data: (data) => ListView(
                          children: data.map((e) => SearchResult(media: e)).toList(),
                        ),
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
                        data: (data) => ListView(
                          children: data.map((e) => SearchResult(media:e)).toList(),
                        ),
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
