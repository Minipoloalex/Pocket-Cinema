import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pocket_cinema/model/comment.dart';
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
    return "User not found";
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

  /*
  Stream<QuerySnapshot> get commentsStream {
    return FirebaseFirestore.instance
        .collection('comments')
        .where('media_id', isEqualTo: widget.media_id)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
    final commentsRef = FirebaseFirestore.instance.collection('comments');
  print("Media_id: $mediaId");
  final commentSnapshot = await commentsRef
      .where("media_id", isEqualTo: mediaId)
      .orderBy('timestamp', descending: true)
      .get();
  final List<QueryDocumentSnapshot> commentDocs = commentSnapshot.docs;
  print("Comment docs: $commentDocs");
  */
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
    // Create document and write data to Firebase
    final docUser = FirebaseFirestore.instance.collection('users').doc(userId);
    await docUser.set(user.toJson());
  }
}
