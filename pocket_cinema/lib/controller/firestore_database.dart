import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pocket_cinema/model/comment.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/model/my_user.dart';

class FirestoreDatabase {
  static Future<String> getUsernameById(String id) async {
    final DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(id);
    final DocumentSnapshot snapshot = await docRef.get();

    if (snapshot.exists) {
      return snapshot.get('username');
    }
    return "Anonymous";
  }

  static Future<String> getEmail(String username) async {
    final usersRef = FirebaseFirestore.instance.collection('users');
    QuerySnapshot snapshot =
        await usersRef.where("username", isEqualTo: username).get();
    if (snapshot.docs.isNotEmpty) {
      String email = snapshot.docs.first.get('email');
      return email;
    }
    return Future.error("User not found");
  }

  static bool isEmail(String str) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(str);
  }

  static void addComment(String mediaId, String text) {
    final commentsRef = FirebaseFirestore.instance.collection('comments');
    commentsRef.add({
      "media_id": mediaId,
      "text": text,
      "user_id": FirebaseAuth.instance.currentUser!.uid,
      "time_posted": Timestamp.now()
    });
  }

  static Future<List<Comment>> getComments(String mediaId) async {
    final commentsRef = FirebaseFirestore.instance.collection('comments');
    final querySnapshot = await commentsRef
        .where("media_id", isEqualTo: mediaId)
        .orderBy('time_posted', descending: true)
        .get();

    final List<DocumentSnapshot> commentDocs = querySnapshot.docs;

    List<Comment> comments = await Future.wait(commentDocs.map((doc) async {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final String userId = data['user_id'];
      final String username = await getUsernameById(userId);

      return Comment(
        mediaID: mediaId,
        username: username,
        userId: userId,
        content: data['text'],
        createdAt: data['time_posted'],
      );
    }));
    return comments;
  }

  static Future<bool> userExists(MyUser user) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("username", isEqualTo: user.username)
        .where("email", isEqualTo: user.email)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  static Future<bool> emailExists(String email) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: email)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  static Future<bool> usernameExists(String username) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("username", isEqualTo: username)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  static Future<void> createUser(MyUser user, String userId) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(userId);
    await docUser.set(user.toJson());
  }

  // Lists

  static Future<void> createPersonalList(String name) async {
    final docList = FirebaseFirestore.instance.collection('lists').doc();
    await docList.set({
      'name': name,
      'mediaIds': [],
      'createdAt': Timestamp.now(),
      'ownerId': FirebaseAuth.instance.currentUser!.uid,
    });

    // Add id to user's lists
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    await docUser.update({
      'personalLists': FieldValue.arrayUnion([docList.id])
    });
  }

  static Future<void> deletePersonalList(String listId) async {
    final docList = FirebaseFirestore.instance.collection('lists').doc(listId);
    await docList.delete();
  }

  static Future<void> addMediaToList(Media media, String listId) async {
    final docList = FirebaseFirestore.instance.collection('lists').doc(listId);
    await docList.update({
      'mediasIds': FieldValue.arrayUnion([media.id])
    });
    mediaExists(media);
  }

  static Future<String> mediaExists(Media media) async{
    final docMedia = FirebaseFirestore.instance.collection('medias').doc(media.id);

    if (!(await docMedia.get()).exists) {
      final Map<String, dynamic> mediaJson = media.toJson();
      if(media.type == MediaType.series) mediaJson['episodes'] = [];
      await docMedia.set(mediaJson);
    }
    return docMedia.id;
  }

  static Future<void> removeMediaFromList(String mediaId, String listId) async {
    final docList = FirebaseFirestore.instance.collection('lists').doc(listId);
    await docList.update({
      'mediasIds': FieldValue.arrayRemove([mediaId])
    });
  }

  static Future<void> toggleMediaStatus(String mediaId, String listName) async {
    if(listName != 'watched' && listName != 'toWatch') {
      throw Exception('Invalid list');
    }

    //TODO: create the media if doesn't exist in the database yet

    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    final DocumentSnapshot snapshot = await docUser.get();
    final List listMedia = snapshot.get(listName);

    if (listMedia.contains(mediaId)) {
      await docUser.update({
        listName: FieldValue.arrayRemove([mediaId])
      });
    } else {
      await docUser.update({
        listName: FieldValue.arrayUnion([mediaId])
      });
    }
  }

}
