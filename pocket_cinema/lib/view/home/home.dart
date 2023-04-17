import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/news_provider.dart';
import 'package:pocket_cinema/view/home/widgets/news_widget.dart';
import 'package:pocket_cinema/view/home/widgets/news_widget_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class NewsList extends ConsumerWidget {
  const NewsList({Key? key}) : super(key: key);

  Future<void> _refreshNews(BuildContext context, WidgetRef ref) async {
    // Refresh your news data here using your provider
    await ref.refresh(newsProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final news = ref.watch(newsProvider);
    return RefreshIndicator(
      onRefresh: () => _refreshNews(context, ref),
      child: news.when(
        data: (news) => ListView(
          children: news.map((news) => NewsCard(news: news)).toList(),
        ),
        loading: () => Shimmer.fromColors(
          period: const Duration(milliseconds: 1000),
          baseColor: Theme.of(context).highlightColor,
          highlightColor: Theme.of(context).colorScheme.onPrimary,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return const NewsCardShimmer();
            },
          ),
        ),
        error: (error, stack) => Center(child: Text(error.toString())),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: NewsList(),
      ),
    );
  }
}
