import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/view/common_widgets/personal_lists.dart';

class BottomModal extends StatelessWidget {
  final Media media;
  const BottomModal({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.tertiary,
      height: 400,
      child: Center(
        child: ListView(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 28, left: 28, right: 28),
                child: ElevatedButton(
                    onPressed: () => addToWatchList(context, media),
                    style: ButtonStyle(
                      //radius
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.secondary),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.onSecondary),
                    ),
                    child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text('Add to Watch',
                            style: TextStyle(fontSize: 23))))),

            PersonalLists(media: media),
          ],
        ),
      ),
    );
  }
}

void addToWatchList(BuildContext context, Media media) {
  FirestoreDatabase().addMediaToWatch(media, FirebaseAuth.instance.currentUser?.uid).then((_) {
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
