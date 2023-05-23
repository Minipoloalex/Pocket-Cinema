import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/model/media_list.dart';
import 'package:pocket_cinema/view/common_widgets/error_widget.dart';
import 'package:pocket_cinema/view/common_widgets/media_list_poster.dart';
import 'package:pocket_cinema/view/common_widgets/poster_shimmer.dart';
import 'package:pocket_cinema/view/common_widgets/shimmer.dart';

class PersonalLists extends ConsumerWidget {
  final Media? media;
  const PersonalLists({super.key, this.media});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<MediaList>> personalList = ref.watch(listsProvider);

    return personalList.when(
      data: (List<MediaList> data) =>
      data.isEmpty
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/no_results_found.png',
            width: 320,
            height: 240,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(
              'Nothing here... Create a list!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      )
          : MediaListList(mediaListList: data, media: media),
      error: (error, stackTrace) {
        Logger().e(error);
        return ErrorOccurred(error: error);
      },
      loading: () => ShimmerEffect(
        child: SizedBox(
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
          ),
        ),
      ),
    );
  }
}
