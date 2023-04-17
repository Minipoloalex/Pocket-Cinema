import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/search_provider.dart';

import 'package:pocket_cinema/view/common_widgets/add_button.dart';
import 'package:pocket_cinema/view/common_widgets/check_button.dart';
import 'package:pocket_cinema/view/common_widgets/go_back_button.dart';
import 'package:pocket_cinema/view/media/widgets/comment_section.dart';

class MediaPage extends ConsumerWidget {
  final String id;
  const MediaPage({super.key, required this.id});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaInfo = ref.watch(mediaProvider(id));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Transform.translate(
          offset: const Offset(10, 0),
          child: const GoBackButton(),
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
                  data: (data) => Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(data.backgroundImage),
                  ),
                  error: (error, stack) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
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
                    error: (error, stack) => Text(error.toString()),
                    loading: () => const CircularProgressIndicator(),
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
                    error: (error, stack) => Text(error.toString()),
                    loading: () => const CircularProgressIndicator(),
                  ),
                ),
                Positioned(
                    top: 212,
                    left: 160,
                    child: Row(
                      children: [
                        const Image(
                          height: 16,
                          width: 16,
                          image: AssetImage('assets/images/star.png'),
                        ),
                        const SizedBox(width: 6),
                        mediaInfo.when(
                          data: (data) => Text(
                            data.rating,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          error: (error, stack) => Text(error.toString()),
                          loading: () => const CircularProgressIndicator(),
                        ),
                        const SizedBox(width: 6),
                        mediaInfo.when(
                          data: (data) => Text(
                            data.nRatings,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          error: (error, stack) => Text(error.toString()),
                          loading: () => const CircularProgressIndicator(),
                        ),
                        const SizedBox(width: 20),
                        const CheckButton(),
                        const AddButton(),
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
                        data.description,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      error: (error, stack) => Text(error.toString()),
                      loading: () => const CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: CommentSection(mediaID: id),
          ),
        ],
      ),
    );
  }
}
