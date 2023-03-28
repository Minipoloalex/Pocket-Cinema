import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/view/common_widgets/horizontal_media_list.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/poster_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _MyLibraryPageState();
}

class _MyLibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Column(
          children: const <Widget>[
            ToWatchList()
          ],
        ),
      ),
    );
  }
}

class ToWatchList extends ConsumerWidget{
  const ToWatchList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Media>> toWatchList = ref.watch(toWatchListProvider);

    return toWatchList.when(
      data: (data) => HorizontalMediaList(
        name: "In your pocket to Watch",
        media: data,
      ),
      // a list of 10 PosterShimmer widgets
      loading: () => Shimmer.fromColors(
              period: const Duration(milliseconds: 1000),
              baseColor: Theme.of(context).highlightColor,
              highlightColor: Theme.of(context).colorScheme.onPrimary,
              child:  SizedBox(
              height: 300,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                itemCount: 7,
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: PosterShimmer(),
                ),
              ))
              ),
      error: (error, stack) => Text(error.toString()),
    );
  }
}
