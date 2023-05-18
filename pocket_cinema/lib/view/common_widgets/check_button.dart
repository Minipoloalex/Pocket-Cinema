import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/model/media.dart';

class CheckButton extends ConsumerWidget {
  final VoidCallback onPressed;
  final String mediaId;

  const CheckButton({super.key, required this.onPressed, required this.mediaId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color checkedColor = Theme.of(context).colorScheme.primary;
    const Color whiteColor = Color.fromARGB(255, 221, 221, 221);

    List<Media> watchedList = ref.watch(watchListProvider);
    bool checked = watchedList.any((element) => element.id == mediaId);
    
    return IconButton(
      icon: const HeroIcon(HeroIcons.check),
      onPressed: () {
        onPressed();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(checked ? checkedColor : null),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        side: MaterialStateProperty.all(
            BorderSide(color: checked ? checkedColor : whiteColor, width: 2)),
        )
      );
    }
}
