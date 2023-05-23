import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/error_widget.dart';
import 'package:pocket_cinema/view/common_widgets/horizontal_media_list.dart';
import 'package:pocket_cinema/view/common_widgets/horizontal_media_list_shimmer.dart';
import 'package:pocket_cinema/view/common_widgets/shimmer.dart';

class ToWatchList extends ConsumerWidget {
  final Function() switchToSearch;
  const ToWatchList({super.key, required this.switchToSearch});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Media>> toWatchList = ref.watch(toWatchListProvider);

    return toWatchList.when(
      data: (data) {
        if (data.isEmpty) {
          return SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Your pocket list is empty.",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Find the movies you would like to see next in here.",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: switchToSearch,
                    child: const Text("Search"),
                  ),
                ],
              ));
        } else {
          return HorizontalMediaList(
            name: "In your pocket to Watch",
            media: data,
            isToWatchProvider: true
          );
        }
      },
      loading: () => const ShimmerEffect(child: HorizontalMediaListShimmer()),
      error: (error, stack) {
        Logger().e(error);
        return ErrorOccurred(error: error);
      },
    );
  }
}
