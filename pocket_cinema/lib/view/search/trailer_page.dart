import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/search_provider.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/add_button.dart';
import 'package:pocket_cinema/view/common_widgets/bottom_modal.dart';
import 'package:pocket_cinema/view/common_widgets/go_back_button.dart';
import 'package:pocket_cinema/view/common_widgets/shimmer.dart';
import 'package:pocket_cinema/view/common_widgets/trailer_player.dart';
import 'package:pocket_cinema/view/search/widgets/trailer_card.dart';
import 'package:pocket_cinema/view/search/widgets/trailer_card_shimmer.dart';

class TrailerPage extends ConsumerStatefulWidget {
  final Media media;
  final String videoUrl;
  const TrailerPage({super.key, required this.media, required this.videoUrl});

  @override
  MyTrailerPageState createState() => MyTrailerPageState();
}

class MyTrailerPageState extends ConsumerState<TrailerPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final trendingTrailersMedia = ref.watch(trendingTrailers);
    trendingTrailersMedia.whenData((data) {
      data.removeWhere((element) => element.id == widget.media.id);
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Transform.translate(
          offset: const Offset(10, 0),
          child: const GoBackButton(key: Key('backButton')),
        ),
      ),
      body: ListView(
        addAutomaticKeepAlives: true,
        padding: EdgeInsets.zero,
        children: [
          TrailerPlayer(videoUrl: widget.videoUrl),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Trailer",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 172, 172, 172),
                        ),
                      ),
                      Text(
                        widget.media.name,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                AddButton(onPressed: () {
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (_) {
                        return BottomModal(
                          media: widget.media,
                        );
                      });
                })
              ],
            ),
          ),

          //say the release date of the media if exists
          Visibility(
            visible: widget.media.releaseDate != null,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
              child:
                  Text("Comes out on ${widget.media.releaseDate ?? 'Unknown'}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 186, 186, 186),
                      )),
            ),
          ),

          const Padding(
              padding: EdgeInsets.fromLTRB(28, 40, 0, 0),
              child: Text("More trending trailers",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 25,
                  ))),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                children: [
                  trendingTrailersMedia.when(
                    data: (data) => (Column(
                        children: data
                            .map((item) => TrailerCard(media: item))
                            .toList())),
                    error: (error, stack) {
                      return const Center(
                        child: Text('Error'),
                      );
                    },
                    loading: () => ShimmerEffect(
                        child: Column(
                      children: List.generate(
                          4, (index) => const TrailerCardShimmer()),
                    )),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
