import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/controller/search_provider.dart';
import 'package:pocket_cinema/model/number_extension.dart';
import 'package:pocket_cinema/view/common_widgets/add_button.dart';
import 'package:pocket_cinema/view/common_widgets/bottom_modal.dart';
import 'package:pocket_cinema/view/common_widgets/check_button.dart';
import 'package:pocket_cinema/view/common_widgets/go_back_button.dart';
import 'package:pocket_cinema/view/common_widgets/shimmer.dart';
import 'package:pocket_cinema/view/media/widgets/comment_section.dart';
import 'package:pocket_cinema/view/media/widgets/description_shimmer.dart';
import 'package:text_scroll/text_scroll.dart';

class MediaPage extends ConsumerStatefulWidget {
  final String id;

  const MediaPage({super.key, required this.id});

  @override
  MediaPageState createState() => MediaPageState();
}

class MediaPageState extends ConsumerState<MediaPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaInfo = ref.watch(mediaProvider(widget.id));

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Transform.translate(
            offset: const Offset(10, 0),
            child: const GoBackButton(key: Key('backButton')),
          ),
        ),
        body: Column(children: [
          Container(
              height: 230,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: mediaInfo.when(
                    data: (data) => FadeInImage(
                      placeholder: const AssetImage('assets/images/placeholder.png'),
                      image: CachedNetworkImageProvider(data.backgroundImage!),
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 500),
                      fadeOutDuration: const Duration(milliseconds: 500),
                      imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                    ).image,
                    error: (error, stack) =>
                        const AssetImage('assets/images/placeholder.png'),
                    loading: () =>
                        const AssetImage('assets/images/placeholder.png'),
                  ),
                  fit: BoxFit.cover,
                ),
                color: Theme.of(context).cardColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(width: 40),
                  SizedBox(
                    width: 100,
                    height: 150,
                    child: mediaInfo.when(
                      data: (data) => FadeInImage(
                        placeholder: const AssetImage('assets/images/placeholder.png'),
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(data.posterImage),
                        fadeInDuration: const Duration(milliseconds: 500),
                        fadeOutDuration: const Duration(milliseconds: 500),
                        imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                      ),
                      error: (error, stack) =>
                          Image.asset('assets/images/placeholder.png'),
                      loading: () => ShimmerEffect(
                        child: Container(
                          width: 100,
                          height: 170,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width - 150,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 30,
                            spreadRadius: 10,
                            // offset: const Offset(0, 200),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mediaInfo.when(
                            data: (data) => Row(
                              children: [
                                Flexible(
                                  child: TextScroll(
                                    data.name,
                                    mode: TextScrollMode.endless,
                                    velocity: const Velocity(
                                        pixelsPerSecond: Offset(50, 0)),
                                    selectable: true,
                                    pauseBetween: const Duration(seconds: 1),
                                    fadedBorder: true,
                                    fadeBorderSide: FadeBorderSide.right,
                                    style: const TextStyle(
                                      fontSize: 28,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            error: (error, stack) => Text(error.toString()),
                            loading: () => ShimmerEffect(
                                child: Container(
                              height: 10,
                              width: 50,
                              color: Colors.black,
                            )),
                          ),
                          Row(
                            children: [
                              mediaInfo.when(
                                data: (data) {
                                  if (data.releaseDate == null) {
                                    return const Text(
                                      'Release date:\nTo be announced',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white70,
                                      ),
                                    );
                                  } else if (DateTime.parse(data.releaseDate!)
                                      .compareTo(DateTime.now()) <
                                      0) {
                                    return Row(children: [
                                      const HeroIcon(HeroIcons.star,
                                          style: HeroIconStyle.solid,
                                          size: 17,
                                          color: Color(0xFFD3A70B)),
                                      const SizedBox(width: 6),
                                      mediaInfo.when(
                                        data: (data) => Text(
                                          data.rating ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        error: (error, stack) =>
                                            Text(error.toString()),
                                        loading: () => ShimmerEffect(
                                            child: Container(
                                              height: 10,
                                              width: 100,
                                              color: Colors.black,
                                            )),
                                      ),
                                      const SizedBox(width: 6),
                                      Tooltip(
                                          message: 'Number of ratings',
                                          child: Row(
                                            children: [
                                              Text(
                                                data.nRatings?.format() ?? '',
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(width: 1),
                                              const HeroIcon(HeroIcons.users,
                                                  style: HeroIconStyle.solid,
                                                  size: 15,
                                                  color: Colors.grey)
                                            ],
                                          ))
                                    ]);
                                  } else {
                                    return Text(
                                      'Release date:\n${data.releaseDate}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white70,
                                      ),
                                    );
                                  }
                                },
                                error: (error, stack) => Text(error.toString()),
                                loading: () => ShimmerEffect(
                                    child: Container(
                                  height: 10,
                                  width: 100,
                                  color: Colors.black,
                                )),
                              ),
                              const SizedBox(width: 20),
                              mediaInfo.when(
                                data: (data) => CheckButton(´
                                    key: Key('${data.name} CheckButton'),
                                    mediaId: data.id,
                                    onPressed: () {
                                      ref
                                          .read(watchListProvider.notifier)
                                          .toggle(data);
                                    }),
                                loading: () => const SizedBox(),
                                error: (error, stack) => Text(error.toString()),
                              ),
                              mediaInfo.when(
                                data: (data) => AddButton(
                                    key: Key('${data.name} AddButton'),
                                    borderColor: Theme.of(context).colorScheme.onPrimary,
                                    onPressed: () {
                                  showModalBottomSheet<void>(
                                      context: context,
                                      builder: (_) {
                                        return BottomModal(
                                          media: data,
                                        );
                                      });
                                }),
                                loading: () => const SizedBox(),
                                error: (error, stack) => Text(error.toString()),
                              ),
                            ],
                          )
                        ],
                      )),
                ],
              )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            color: Theme.of(context).cardColor,
            child: mediaInfo.when(
              data: (data) => Text(
                data.description ?? '',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              error: (error, stack) => Text(error.toString()),
              loading: () => const ShimmerEffect(child: DescriptionShimmer()),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: CommentSection(mediaID: widget.id),
          ),
        ]),
      ),
    );
  }
}
