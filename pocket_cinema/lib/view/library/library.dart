import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/view/common_widgets/horizontal_media_list.dart';
import 'package:pocket_cinema/model/media.dart';

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
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text(error.toString()),
    );
  }
}