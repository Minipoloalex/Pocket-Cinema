import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/model/media_list.dart';
import 'package:pocket_cinema/view/media_list/media_list.dart';
import 'package:transparent_image/transparent_image.dart';

class MediaListPoster extends ConsumerStatefulWidget {
  final String name;
  final MediaList mediaList;
  final Media? media;

  const MediaListPoster(
      {Key? key, required this.name, required this.mediaList, this.media})
      : super(key: key);

  @override
  MediaListPosterState createState() => MediaListPosterState();
}

class MediaListPosterState extends ConsumerState<MediaListPoster> {
  _onTap(BuildContext context) {
    if (widget.media != null) {
      FirestoreDatabase.toggleMediaInList(widget.media!, widget.mediaList.id)
          .then((value) {
        Fluttertoast.showToast(
          msg: "${widget.media!.name} was $value ${widget.mediaList.name}",
          timeInSecForIosWeb: 1,
        );
        ref.refresh(listsProvider).value;
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
          msg:
              "Some error occur while adding ${widget.media!.name} to ${widget.mediaList.name}",
          timeInSecForIosWeb: 1,
        );
      });
    } else {
      // Open list
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MediaListPage(
            name: widget.mediaList.name,
            mediaList: widget.mediaList.media,
            listId: widget.mediaList.id),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = widget.mediaList.media.contains(widget.media);

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return GestureDetector(
        onTap: () => _onTap(context),
        child: Stack(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (widget.mediaList.media.length >= 2) ...[
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                      width: 157 / 2,
                      height: 117,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FadeInImage(
                            placeholder: MemoryImage(kTransparentImage),
                            image: CachedNetworkImageProvider(widget.mediaList.media[0].posterImage),
                            fadeInDuration: const Duration(milliseconds: 500),
                            fadeOutDuration: const Duration(milliseconds: 500),
                            imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                          ).image,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                      )),
                  Container(
                    width: 157 / 2,
                    height: 117,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FadeInImage(
                            placeholder: MemoryImage(kTransparentImage),
                            image: CachedNetworkImageProvider(widget.mediaList.media[1].posterImage),
                            fadeInDuration: const Duration(milliseconds: 500),
                            fadeOutDuration: const Duration(milliseconds: 500),
                            imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                          ).image,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                  )
                ]),
              ] else if (widget.mediaList.media.length == 1) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 157 / 2,
                        height: 117,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FadeInImage(
                              placeholder: MemoryImage(kTransparentImage),
                              image: CachedNetworkImageProvider(widget.mediaList.media[0].posterImage),
                              fadeInDuration: const Duration(milliseconds: 500),
                              fadeOutDuration: const Duration(milliseconds: 500),
                              imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                            ).image,
                            fit: BoxFit.cover,
                            // alignment: Alignment.topCenter
                          ),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5)),
                        )),
                    Container(
                        width: 157 / 2,
                        height: 117,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                        ),
                        child: const Center(
                          child:
                          HeroIcon(HeroIcons.film, style: HeroIconStyle.solid),
                        )),
                  ],
                ),
              ] else ...[
                Container(
                    width: 157,
                    height: 117,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: const Center(
                      child: HeroIcon(HeroIcons.film, style: HeroIconStyle.solid),
                    )),
              ],
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: SizedBox(
                    width: 157,
                    child: Text(widget.name,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2)),
              )
            ]),
            Visibility(
                visible: widget.media != null && isChecked,
                child: Positioned(
                    top: 0,
                    right: 0,
                    child: Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    )
                )
            )
          ],
        ));
  }
}

class MediaListList extends StatelessWidget {
  final List<MediaList> mediaListList;
  final Media? media;

  const MediaListList({Key? key, required this.mediaListList, this.media})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final columnChildren = <Widget>[];
    final rows = (mediaListList.length / 2).ceil();

    for (int i = 0; i < rows; i++) {
      final rowChildren = <Widget>[];
      for (int j = 0; j < 2; j++) {
        final index = i * 2 + j;
        if (index < mediaListList.length) {
          rowChildren.add(
            MediaListPoster(
                name: mediaListList[index].name,
                mediaList: mediaListList[index],
                media: media),
          );
        }
      }
      columnChildren.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: rowChildren.length == 2
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.start,
          children: rowChildren
              .map((widget) => Padding(
                    padding: EdgeInsets.only(
                        top: 25.0, left: (rowChildren.length == 2) ? 0 : 25.0),
                    child: widget,
                  ))
              .toList(),
        ),
      );
    }

    return Column(
      children: columnChildren,
    );
  }
}
