import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pocket_cinema/model/comment.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/model/media_list.dart';
import 'package:pocket_cinema/model/my_user.dart';

class FirestoreDatabase {
  FirestoreDatabase({FirebaseFirestore? firestore}) : firestore = firestore ?? FirebaseFirestore.instance;
  final FirebaseFirestore firestore;

  Future<String> getUsernameById(String id) async {
    final DocumentReference docRef = firestore.collection('users').doc(id);
    final DocumentSnapshot snapshot = await docRef.get();

    if (snapshot.exists) {
      return snapshot.get('username');
    }
    return "Anonymous";
  }

  Future<String> getEmail(String username) async {
    final usersRef = firestore.collection('users');
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

  void addComment(String mediaId, String text, String userId) {
    final commentsRef = firestore.collection('comments');
    commentsRef.add({
      "media_id": mediaId,
      "text": text,
      "user_id": userId,  // TODO
      "time_posted": Timestamp.now()
    });
  }

  Future<List<Comment>> getComments(String mediaId) async {
    final commentsRef = firestore.collection('comments');
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

  Future<bool> userExists(MyUser user) async {
    final QuerySnapshot snapshot = await firestore.collection('users')
        .where("username", isEqualTo: user.username)
        .where("email", isEqualTo: user.email)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<bool> emailExists(String email) async {
    final QuerySnapshot snapshot = await firestore.collection('users')
        .where("email", isEqualTo: email)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<bool> usernameExists(String username) async {
    final QuerySnapshot snapshot = await firestore.collection('users')
        .where("username", isEqualTo: username)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<void> createUser(MyUser user, String userId) async {
    final docUser = firestore.collection('users').doc(userId);
    await docUser.set(user.toJson());
  }


  Future<void> createPersonalList(String name, String userId) async {
    final docList = firestore.collection('lists').doc();
    await docList.set({
      'name': name,
      'mediaIds': [],
      'createdAt': Timestamp.now(),
      'lastUpdatedAt': Timestamp.now(),
      'ownerId': userId,
    });

    final docUser = firestore.collection('users').doc(userId);

    await docUser.update({
      'personalLists': FieldValue.arrayUnion([docList.id])
    });
  }

  Future<List<MediaList>> getPersonalLists(String? userId) async {
    if (userId == null) {
      return [];
    }
    final personalListRef = firestore.collection('lists');
    final querySnapshot = await personalListRef
        .where("ownerId", isEqualTo: userId)
        .orderBy('lastUpdatedAt', descending: true)
        .get();
    final List<MediaList> mediaLists = [];
    for (final doc in querySnapshot.docs) {
      final id = doc.id;
      final name = doc.data()['name'] as String;
      final mediaIds = doc.data()['mediaIds'] as List<dynamic>;
      final createdAt = doc.data()['createdAt'] as Timestamp;
      final lastUpdatedAt = doc.data()['lastUpdatedAt'] as Timestamp;
      final List<Media> media = await Future.wait(mediaIds.map((mediaId) async {
        final mediaSnapshot = await firestore.collection('medias')
            .doc(mediaId).get();
        return Media(
          id: mediaSnapshot.id,
          name: mediaSnapshot.get('name'),
          posterImage: mediaSnapshot.get('posterUrl'),
        );
      }));
      mediaLists.add(MediaList(id: id, name: name, media: media, createdAt: createdAt, lastUpdatedAt: lastUpdatedAt));
    }
    return mediaLists;
  }

  Future<void> deletePersonalList(String listId) async {
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception('User not logged in');
    }
    final docList = firestore.collection('lists').doc(listId);
    await docList.delete();
    final docUser = firestore.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await docUser.update({
      'personalLists': FieldValue.arrayRemove([listId])
    });
  }
  Future<void> addMediaToList(Media media, String listId) async {
    final docList = firestore.collection('lists').doc(listId);
    await docList.update({
      'mediaIds': FieldValue.arrayUnion([media.id]),
      'lastUpdatedAt': Timestamp.now(),
    });
    mediaExists(media);
  }

  Future<String> mediaExists(Media media) async {
    final docMedia = firestore.collection('medias').doc(media.id);

    if (!(await docMedia.get()).exists) {
      final Map<String, dynamic> mediaJson = media.toJson();
      if (media.type == MediaType.series) mediaJson['episodes'] = [];
      await docMedia.set(mediaJson);
    }
    return docMedia.id;
  }

  Future<void> removeMediaFromList(String mediaId, String listId) async {
    final docList = firestore.collection('lists').doc(listId);
    await docList.update({
      'mediaId': FieldValue.arrayRemove([mediaId]),
      'lastUpdatedAt': Timestamp.now(),
    });
  }

  Future<void> addMediaToWatch(Media media) async {
    if (FirebaseAuth.instance.currentUser == null){
      throw Exception('User not logged in');
    }
    mediaExists(media);
    final docUser = firestore.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    final userSnapshot = await docUser.get();
    final List listMedia = userSnapshot.data()?["ToWatch"] ?? [];
    if (listMedia.contains(media.id)) throw Exception("Already added");
    await docUser.update({
      "ToWatch": FieldValue.arrayUnion([media.id])
    });
    return;
  }

  Future<void> toggleMediaStatus(Media media, String listName) async {
    if (listName != 'watched' && listName != 'toWatch') {
      throw Exception('Invalid list');
    }

    if(FirebaseAuth.instance.currentUser == null) {
      throw Exception('User not logged in');
    }

    mediaExists(media);

    final docUser = firestore.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);


    final userSnapshot = await docUser.get();
    final List listMedia = userSnapshot.data()?[listName] ?? [];

    if (listMedia.contains(media.id)) {
      await docUser.update({
        listName: FieldValue.arrayRemove([media.id])
      });
    } else {
      await docUser.update({
        listName: FieldValue.arrayUnion([media.id])
      });
    }
  }

  Future<List<Media>> getPredefinedList(String listName) async {
    if (listName != "watched" && listName != "ToWatch") {
      throw Exception("List name given incorrect");
    }
    if (FirebaseAuth.instance.currentUser == null) {
      return [];
    }
    final userSnapshot = await firestore.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    final List list = userSnapshot.data()?[listName] ?? [];

    final List<Media> medias =
        await Future.wait(list.map((mediaId) async {
      final mediaSnapshot = await firestore.collection('medias')
          .doc(mediaId)
          .get();
      return Media(
        id: mediaSnapshot.id,
        name: mediaSnapshot.get('name'),
        posterImage: mediaSnapshot.get('posterUrl'),
      );
    }));
    return medias;
  }
}
