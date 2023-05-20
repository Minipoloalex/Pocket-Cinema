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
    const posterPath = 'posterPath';
    const title = 'title';
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
    test('adding media to personal list and removing it from that list', () async {
      final database = FirestoreDatabase(firestore: firebaseFirestore);
      await createDefaultUser(database, username, email, id);

      final listId = await createDefaultList(database, listName, id);

      final media = Media(id: mediaId, name: title, posterImage: posterPath);
      await database.addMediaToList(media, listId);

      List<MediaList> lists = await database.getPersonalLists(id);
      expect(lists[0].media, isNotEmpty);
      expect(lists[0].media[0].id, mediaId);
      expect(lists[0].media[0].name, title);
      expect(lists[0].media[0].posterImage, posterPath);

      await database.removeMediaFromList(mediaId, listId);
      lists = await database.getPersonalLists(id);
      expect(lists[0].media, isEmpty, reason: "Media should have been removed from the list");
    });
    test('adding a list and deleting it', () async {
      final database = FirestoreDatabase(firestore: firebaseFirestore);
      await createDefaultUser(database, username, email, id);
      String listId = await createDefaultList(database, listName, id);

      await database.deletePersonalList(listId, id);
      expect(database.getPersonalLists(id), completion(isEmpty));
    });
    test('adding media to Pocket to watch list', () async  {
      final database = FirestoreDatabase(firestore: firebaseFirestore);
      final media = Media(id: mediaId, name: title, posterImage: posterPath);
      createDefaultUser(database, username, email, id);
      await database.addMediaToWatch(media, id);

      final List<Media> toWatchList = await database.getPredefinedList('ToWatch', id);
      expect(toWatchList.length, 1);
      expect(toWatchList[0].id, mediaId);
      expect(toWatchList[0].name, title);
      expect(toWatchList[0].posterImage, posterPath);

      expect(() => database.addMediaToWatch(media, id), throwsException);
    });
  });
}
