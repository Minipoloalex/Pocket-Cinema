/*
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:pocket_cinema/model/media.dart';

class BottomModal extends StatelessWidget {
  final Media media;
  const BottomModal({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.tertiary,
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => addToWatchList(context, media),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.secondary),
                foregroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.onSecondary),
              ),
              child: const Text('To Watch'),
            ),

            // TODO: lists (lists posters)
          ],
        ),
      ),
    );
  }
}

void addToWatchList(BuildContext context, Media media) {
  FirestoreDatabase.addMediaToWatch(media).then((_) {
    Fluttertoast.showToast(
      msg: "${media.name} was added to the to watch list",
      timeInSecForIosWeb: 1,
    );
  }).onError((error, stackTrace) {
    if (error.toString() == "Exception: Already added") {
      Fluttertoast.showToast(
        msg: "${media.name} has already been added",
        timeInSecForIosWeb: 1,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Some error occur while adding ${media.name}",
        timeInSecForIosWeb: 1,
      );
    }
  });
}
*/
