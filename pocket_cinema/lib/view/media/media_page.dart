import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:logger/logger.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/controller/search_provider.dart';
import 'package:pocket_cinema/view/common_widgets/add_button.dart';
import 'package:pocket_cinema/view/common_widgets/bottom_modal.dart';
import 'package:pocket_cinema/view/common_widgets/check_button.dart';
import 'package:pocket_cinema/view/common_widgets/error_widget.dart';
import 'package:pocket_cinema/view/common_widgets/go_back_button.dart';
import 'package:pocket_cinema/view/common_widgets/shimmer.dart';
import 'package:pocket_cinema/view/media/widgets/comment_section.dart';
import 'package:pocket_cinema/view/media/widgets/description_shimmer.dart';
import 'package:pocket_cinema/model/number_extension.dart';

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
    ref.refresh(watchedListProvider).value;
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 310,
              color: Theme.of(context).cardColor,
              child: Stack(
                children: [
                  mediaInfo.when(
                    data: (data) => Stack(
                      children: [
                        data.backgroundImage != ""
                            ? FadeInImage(
                                height: 210,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  data.backgroundImage!,
                                ),
                                fadeInDuration:
                                    const Duration(milliseconds: 100),
                                placeholder: const AssetImage(
                                    'assets/images/placeholder.png'),
                              )
                            : const Image(
                                image:
                                    AssetImage('assets/images/placeholder.png'),
                                height: 210,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                        ClipRect(
                          child: Align(
                            heightFactor: 1,
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 210,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.9),
                                    blurRadius: 30,
                                    spreadRadius: 10,
                                    offset: const Offset(0, 200),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    error: (error, stack) {
                      Logger().e(error);
                      return const ErrorOccurred();
                    },
                    loading: () => const Image(
                      height: 200,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      image: AssetImage('assets/images/placeholder.png'),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 40,
                    child: mediaInfo.when(
                      data: (data) => Container(
                        width: 108,
                        height: 188,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(data.posterImage),
                          ),
                        ),
                      ),
                      error: (error, stack) {
                        Logger().e(error);
                        return const ErrorOccurred();
                      },
                      loading: () => ShimmerEffect(
                          child: Container(
                        height: 188,
                        width: 108,
                        color: Colors.black,
                      )),
                    ),
                  ),
                  Positioned(
                    top: 172,
                    left: 160,
                    child: mediaInfo.when(
                      data: (data) => Text(
                        data.name,
                        style: const TextStyle(
                          fontSize: 28,
                        ),
                      ),
                      error: (error, stack) {
                        Logger().e(error);
                        return const ErrorOccurred();
                      },
                      loading: () => ShimmerEffect(
                          child: Container(
                        height: 10,
                        width: 50,
                        color: Colors.black,
                      )),
                    ),
                  ),
                  Positioned(
                      top: 212,
                      left: 160,
                      child: Row(
                        children: [
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
                            error: (error, stack) {
                              Logger().e(error);
                              return const ErrorOccurred();
                            },
                            loading: () => ShimmerEffect(
                                child: Container(
                              height: 10,
                              width: 100,
                              color: Colors.black,
                            )),
                          ),
                          const SizedBox(width: 6),
                          mediaInfo.when(
                            data: (data) => Tooltip(
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
                                )),
                            error: (error, stack) {
                              Logger().e(error);
                              return const ErrorOccurred();
                            },
                            loading: () => ShimmerEffect(
                                child: Container(
                              height: 10,
                              width: 100,
                              color: Colors.black,
                            )),
                          ),
                          const SizedBox(width: 20),
                          mediaInfo.when(
                            data: (data) => CheckButton(
                                initialChecked: data.watched ?? false,
                                onPressed: () {
                                  FirestoreDatabase.toggleMediaStatus(
                                      data, "watched");
                                }),
                            loading: () => const SizedBox(),
                            error: (error, stack) {
                              Logger().e(error);
                              return const ErrorOccurred();
                            },
                          ),
                          mediaInfo.when(
                            data: (data) => AddButton(onPressed: () {
                              showModalBottomSheet<void>(
                                  context: context,
                                  builder: (_) {
                                    return BottomModal(
                                      media: data,
                                    );
                                  });
                            }),
                            loading: () => const SizedBox(),
                            error: (error, stack) {
                              Logger().e(error);
                              return const ErrorOccurred();
                            },
                          ),
                          //
                        ],
                      )),
                  Positioned(
                    top: 262,
                    left: 40,
                    child: SizedBox(
                      width: 350,
                      height: 40,
                      child: mediaInfo.when(
                        data: (data) => Text(
                          data.description ?? '',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        error: (error, stack) {
                          Logger().e(error);
                          return const ErrorOccurred();
                        },
                        loading: () =>
                            const ShimmerEffect(child: DescriptionShimmer()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: CommentSection(mediaID: widget.id),
            ),
          ],
        ),
      ),
    );
  }
}
