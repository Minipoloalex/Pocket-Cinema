import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/controller/search_provider.dart';
import 'package:pocket_cinema/view/search/widgets/search_result.dart';

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
    _tabController.addListener(() {
      ref.read(searchTypeProvider.notifier).state = _tabController.index == 0 ? SearchType.movies : SearchType.shows;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final results = ref.watch(searchResultsProvider);

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
                      results.when(
                        data: (data) => Column(
                          children: data.map((e) => SearchResult(
                            poster: e.posterUrl,
                            title: e.name,
                            descritpion: e.description ?? '',
                          )).toList(),
                        ),
                        loading: () => const CircularProgressIndicator(),
                        error: (error, stack) => const Text("error"),
                      ),
                      results.when(
                        data: (data) => Column(
                          children: data.map((e) => SearchResult(
                            poster: e.posterUrl,
                            title: e.name,
                            descritpion: e.description ?? '',
                          )).toList(),
                        ),
                        loading: () => const CircularProgressIndicator(),
                        error: (error, stack) => const Text("error"),
                      ),
                    ],
                  )))
        ],
      ),
    ));
  }
}
