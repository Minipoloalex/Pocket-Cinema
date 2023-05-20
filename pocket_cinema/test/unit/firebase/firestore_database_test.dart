import 'package:pocket_cinema/model/comment.dart';
import 'package:pocket_cinema/model/media.dart';
import 'package:pocket_cinema/model/media_list.dart';
import 'package:pocket_cinema/model/my_user.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

Future<String> createDefaultList(FirestoreDatabase database, String listName, String userId) async {
  await database.createPersonalList(listName, userId);
  List<MediaList> lists = await database.getPersonalLists(userId);
  expect(lists.length, 1);
  expect(lists[0].name, listName);
  expect(lists[0].id, isNotNull);
  expect(lists[0].media, isEmpty);
  return lists[0].id;
}

Future<void> createDefaultUser(FirestoreDatabase database, String username, String email, String id) async {
  await database.createUser(MyUser(username: username, email: email), id);
}

void main() {
  group('FirestoreDatabase', () {
    FakeFirebaseFirestore? firebaseFirestore;
    const id = '123';
    const username = 'John';
    const email = 'john@gmail.com';
    const mediaId = '456';
    const text = 'Great movie!';
    const listName = 'My list';
    setUp(() {
      firebaseFirestore = FakeFirebaseFirestore();
    });
    test('getUsernameById', () {
      final database = FirestoreDatabase(firestore: firebaseFirestore);

      createDefaultUser(database, username, email, id);
      expect(database.getUsernameById(id), completion(username));

      expect(database.emailExists(email), completion(true));
      expect(database.usernameExists(username), completion(true));
    });
    test('getEmail', () {
      final database = FirestoreDatabase(firestore: firebaseFirestore);
      createDefaultUser(database, username, email, id);
      expect(database.getEmail(username), completion(email));
    });
    test('isEmail', () {
      expect(FirestoreDatabase.isEmail(email), true, reason: '$email is a valid email');
      expect(FirestoreDatabase.isEmail('john@gmail'), false, reason: 'john@gmail is not a valid email');
    });
    test('addComment and getComments', () async {
      final database = FirestoreDatabase(firestore: firebaseFirestore);
      database.addComment(mediaId, text, id);
      List<Comment> comments = await database.getComments(mediaId);
      expect(comments.length, 1);
      expect(comments[0].content, text);
      expect(comments[0].userId, id);
      expect(comments[0].mediaID, mediaId);
    });
    test('userExists', () {
      final database = FirestoreDatabase(firestore: firebaseFirestore);
      createDefaultUser(database, username, email, id);
      expect(database.userExists(MyUser(username: username, email: email)), completion(true));
    });
    test('createPersonalList', () async {
      final database = FirestoreDatabase(firestore: firebaseFirestore);
      await createDefaultUser(database, username, email, id);
      await createDefaultList(database, listName, id);
    });
    test('adding media to personal list and checking if it is there', () async {
      final database = FirestoreDatabase(firestore: firebaseFirestore);
      const posterPath = 'posterPath';
      const title = 'title';

      await createDefaultUser(database, username, email, id);
      final listId = await createDefaultList(database, listName, id);

      Media media = Media(id: mediaId, name: title, posterImage: posterPath);
      await database.addMediaToList(media, listId);

      final List<MediaList> lists = await database.getPersonalLists(id);
      expect(lists[0].media, isNotEmpty);
      expect(lists[0].media[0].id, mediaId);
      expect(lists[0].media[0].name, title);
      expect(lists[0].media[0].posterImage, posterPath);
    });
  });
}