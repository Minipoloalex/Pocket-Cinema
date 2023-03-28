import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/view/common_widgets/horizontal_media_list.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/view/library/widgets/list_button.dart';

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
          children: <Widget>[
            const ToWatchList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListButton(
                  icon: const HeroIcon(HeroIcons.checkCircle,
                      style: HeroIconStyle.solid),
                  labelText: "Watched",
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                ListButton(
                  icon: const HeroIcon(HeroIcons.ellipsisHorizontalCircle,
                      style: HeroIconStyle.solid),
                  labelText: "Watching",
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ToWatchList extends ConsumerWidget {
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
