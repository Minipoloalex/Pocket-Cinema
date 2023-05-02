import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:pocket_cinema/model/media.dart';

class CheckButton extends StatefulWidget {
  final Media media;
  const CheckButton({super.key, required this.media});

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  late bool _isChecked = false;
  @override
  void initState() {
    super.initState();
    FirestoreDatabase.isMediaWatched(widget.media.id).then((value) {
      setState(() {
        _isChecked = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final Color checkedColor = Theme.of(context).colorScheme.primary;
    const Color whiteColor = Color.fromARGB(255, 221, 221, 221);
    return IconButton(
      icon: const HeroIcon(HeroIcons.check),
      onPressed: () {
        setState(() {
          _isChecked = !_isChecked;
          FirestoreDatabase.toggleMediaStatus(widget.media, "watched");
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(_isChecked ? checkedColor : null),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        side: MaterialStateProperty.all(
            BorderSide(color: _isChecked ? checkedColor : whiteColor, width: 2)),
      ),
    );
  }
}
