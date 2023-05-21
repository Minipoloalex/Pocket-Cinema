import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pocket_cinema/controller/authentication.dart';
import 'package:mockito/mockito.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:pocket_cinema/model/my_user.dart';

class MockFirestoreDatabase extends Mock implements FirestoreDatabase {
  @override
  Future<bool> userExists(MyUser user) {
    return super.noSuchMethod(
      Invocation.method(#userExists, [user]),
      returnValue: Future.value(false),
    );
  }
  @override
  Future<void> createUser(MyUser user, String userId) {
    return super.noSuchMethod(
      Invocation.method(#createUser, [user, userId]),
      returnValue: Future.value(),
    );
  }
}
class MyMockGoogleSignIn extends Mock implements GoogleSignIn {
  @override
  Future<GoogleSignInAccount?> signOut() async {
    return null;
  }
}
MockFirestoreDatabase setupDatabase(MyUser user, String userId) {
  MockFirestoreDatabase database = MockFirestoreDatabase();
  when(database.userExists(user)).thenAnswer((_) => Future.value(false));
  when(database.createUser(user, userId)).thenAnswer((_) => Future.value());
  return database;
}

void main() {
  FirebaseAuth? auth;
  const userId = '12345';
  const userEmail = 'email@gmail.com';
  const username = 'username';
  group('Authentication - user signed in', () {
    setUp(() {
      auth = MockFirebaseAuth(mockUser: MockUser(
        uid: userId,
        email: userEmail,
        displayName: username,
      ), signedIn: true);
    });
    test('createUserGoogleSignIn', () async {
      Authentication authentication = Authentication(auth: auth);
      MyUser user = MyUser(
          username: username,
          email: userEmail
      );
      MockFirestoreDatabase database = setupDatabase(user, userId);

      await authentication.createUserGoogleSignIn(user, database);
      verify(database.createUser(user, userId));
    });
    test('sign out', () async {
      final googleSignIn = MyMockGoogleSignIn();

      Authentication authentication = Authentication(auth: auth);
      await authentication.signOut(googleSignIn);

      expect(auth!.currentUser, null);
    });
  });
}
