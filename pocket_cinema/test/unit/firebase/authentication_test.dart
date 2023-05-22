import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
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
class MockFirestoreDatabaseUserNotSignedIn extends Mock implements FirestoreDatabase {
  @override
  Future<void> createUser(MyUser user, String userId) {
    return Future.value();
  }
  @override
  Future<String> getEmail(String username) {
    return Future.value('email@gmail.com');
  }
  @override
  Future<bool> userExists(MyUser user) {
    return Future.value(false);
  }
}
class MyMockGoogleSignIn extends Mock implements GoogleSignIn {
  @override
  Future<GoogleSignInAccount?> signOut() async {
    return null;
  }
}
MockFirestoreDatabase setupLoggedInDatabase(MyUser user, String userId) {
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
  const password = 'password';
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
      MockFirestoreDatabase database = setupLoggedInDatabase(user, userId);

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
  group('Authentication - user not signed in', (){
    setUp(() {
      auth = MockFirebaseAuth(signedIn: false);
    });
    test('registering a new user', () async {
      Authentication authentication = Authentication(auth: auth);
      MockFirestoreDatabaseUserNotSignedIn database = MockFirestoreDatabaseUserNotSignedIn();

      await authentication.registerUser(username, userEmail, password, database);
      expect(auth?.currentUser, isNotNull);
    });
    test('sign in with email and password', () async {
      Authentication authentication = Authentication(auth: auth);
      MockFirestoreDatabaseUserNotSignedIn database = MockFirestoreDatabaseUserNotSignedIn();

      await authentication.signIn(userEmail, password, database);
      expect(auth?.currentUser, isNotNull);
    });
    test('sign in with username and password', () async {
      Authentication authentication = Authentication(auth: auth);
      MockFirestoreDatabaseUserNotSignedIn database = MockFirestoreDatabaseUserNotSignedIn();

      await authentication.signIn(username, password, database);
      expect(auth?.currentUser, isNotNull);
    });
    test('sign in with google', () async {
      Authentication authentication = Authentication(auth: auth);
      MockGoogleSignIn googleSignIn = MockGoogleSignIn();
      googleSignIn.setIsCancelled(false);

      final User? user = await authentication.signInWithGoogle(googleSignIn);
      expect(user, isNotNull);
      expect(auth?.currentUser, isNotNull);
    });
    test('sign in with google cancelled', () {
      Authentication authentication = Authentication(auth: auth);
      MockGoogleSignIn googleSignIn = MockGoogleSignIn();
      googleSignIn.setIsCancelled(true);

      expect(() => authentication.signInWithGoogle(googleSignIn), throwsA(isA<String>()));
      expect(auth?.currentUser, isNull);
    });
    test('creating user google sign in - error for not being logged in', () {
      Authentication authentication = Authentication(auth: auth);
      MockFirestoreDatabaseUserNotSignedIn database = MockFirestoreDatabaseUserNotSignedIn();
      final MyUser user = MyUser(
          username: username,
          email: userEmail
      );
      expect(auth?.currentUser, isNull);
      expect(() => authentication.createUserGoogleSignIn(user, database), throwsException);
    });
  });
}
