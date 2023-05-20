import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:pocket_cinema/controller/news_provider.dart';
import 'package:pocket_cinema/view/common_widgets/error_widget.dart';
import 'package:pocket_cinema/view/common_widgets/shimmer.dart';
import 'package:pocket_cinema/view/common_widgets/logo_title_app_bar.dart';
import 'package:pocket_cinema/view/home/widgets/news_widget.dart';
import 'package:pocket_cinema/view/home/widgets/news_widget_shimmer.dart';

class NewsList extends ConsumerWidget {
  const NewsList({Key? key}) : super(key: key);

  Future<void> _refreshNews(BuildContext context, WidgetRef ref) async {
    ref.refresh(newsProvider).value;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final news = ref.watch(newsProvider);
    return RefreshIndicator(
      onRefresh: () => _refreshNews(context, ref),
      child: news.when(
        data: (news) => ListView(
          children: [
            const Text(
              "News",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 42,
              ),
            ),
            const SizedBox(height: 10),
            ...news
                .map((news_) => NewsCard(
                      key: Key("newsCard${news.indexOf(news_)}"),
                      news: news_,
                    ))
                .toList(),
          ],
        ),
        loading: () => ShimmerEffect(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return const NewsCardShimmer();
            },
          ),
        ),
        error: (error, stack) {
          if (error is SocketException) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                const SizedBox(height: 10),
                const NetworkErrorOccurred(),
              ],
            );
          } else {
            Logger().e(error);
            return const ErrorOccurred();
          }
        },
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const LogoTitleAppBar(),
      ),
      body: const Center(
        child: NewsList(),
      ),
    );
  }
}
