import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/add_button.dart';
import 'package:pocket_cinema/view/common_widgets/bottom_modal.dart';
import 'package:pocket_cinema/view/common_widgets/check_button.dart';
import 'package:pocket_cinema/view/media/media_page.dart';

class SearchResult extends ConsumerStatefulWidget {
  final Media media;
  const SearchResult({Key? key, required this.media}) : super(key: key);

  @override
  SearchResultState createState() => SearchResultState();
}

class SearchResultState extends ConsumerState<SearchResult> {

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          key: Key(widget.media.name),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => MediaPage(id: widget.media.id))),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.media.posterImage),
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
                      widget.media.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.media.description ?? '',
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
                      mediaId: widget.media.id,
                      onPressed: () {
                        ref.read(watchListProvider.notifier).toggle(widget.media);
                      }),
                  AddButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (_) {
                            return BottomModal(
                              media: widget.media,
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
