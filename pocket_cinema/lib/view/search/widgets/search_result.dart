import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/add_button.dart';
import 'package:pocket_cinema/view/common_widgets/bottom_modal.dart';
import 'package:pocket_cinema/view/common_widgets/check_button.dart';
import 'package:pocket_cinema/view/media/media_page.dart';

class SearchResult extends ConsumerWidget {
  final Media media;
  const SearchResult({super.key, required this.media});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          key: Key(media.name),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MediaPage(id: media.id))),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FadeInImage(
                      placeholder: const AssetImage('assets/images/placeholder.png'),
                      image: CachedNetworkImageProvider(media.posterImage),
                      fadeInDuration: const Duration(milliseconds: 500),
                      fadeOutDuration: const Duration(milliseconds: 500),
                      imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                    ).image,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      media.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      media.description ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  CheckButton(
                      mediaId: media.id,
                      onPressed: () {
                        ref.read(watchListProvider.notifier).toggle(media);
                      }),
                  AddButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (_) {
                            return BottomModal(
                              media: media,
                            );
                          });
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
