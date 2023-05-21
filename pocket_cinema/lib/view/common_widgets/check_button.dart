import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/model/media.dart';

class CheckButton extends ConsumerWidget {
  final VoidCallback onPressed;
  final String mediaId;
  final String? tooltip;

  const CheckButton({
    Key? key,
    required this.onPressed,
    required this.mediaId,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color checkedColor = Theme.of(context).colorScheme.primary;
    const Color whiteColor = Color.fromARGB(255, 221, 221, 221);

    List<Media> watchedList = ref.watch(watchListProvider);
    bool checked = watchedList.any((element) => element.id == mediaId);

    return Tooltip(
      message: tooltip ?? 'Mark this movie as watched',
      child: IconButton(
        icon: const HeroIcon(HeroIcons.check),
        onPressed: () {
          onPressed();
          showWatchedToast(checked, ref);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(checked ? checkedColor : null),
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          side: MaterialStateProperty.all(
            BorderSide(color: checked ? checkedColor : whiteColor, width: 2),
          ),
        ),
      ),
    );
  }

  void showWatchedToast(bool checked, WidgetRef ref) {
    String mediaName = ''; // Variable to store the media name
    List<Media> watchedList = ref.watch(watchListProvider);
    Media? media;
    for (var element in watchedList) {
      if (element.id == mediaId) {
        media = element;
        break;
      }
    }
    if (media != null) {
      mediaName = media.name;
    }

    if (checked) {
      Fluttertoast.showToast(
        msg: '$mediaName was removed from the watched list',
        timeInSecForIosWeb: 1,
      );
    } else {
      Fluttertoast.showToast(
        msg: '$mediaName was added to the watched list',
        timeInSecForIosWeb: 1,
      );
    }
  }
}
