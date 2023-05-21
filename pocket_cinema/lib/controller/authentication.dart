import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pocket_cinema/controller/validate.dart';
import 'package:pocket_cinema/model/my_user.dart';

import 'firestore_database.dart';

class Authentication {
  Authentication({FirebaseAuth? auth}) :  auth = auth ?? FirebaseAuth.instance;
  final FirebaseAuth auth;

  Future<void> signOut([GoogleSignIn? googleSignIn]) async {
    googleSignIn ??= GoogleSignIn();
    await googleSignIn.signOut();
    await auth.signOut();
  }
  Future signIn(String user, String password, [FirestoreDatabase? database]) async {
    database ??= FirestoreDatabase();
    try {
      final email = Validate.isEmail(user) ? user : await database.getEmail(user);

      await auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return Future.value();
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message ?? "Something went wrong");
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  Future<User?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return Future.error("Sign in aborted by user");
    }

    final googleAuth = await googleUser.authentication;
    if (googleAuth.idToken != null) {
      final userCredential = await auth.signInWithCredential(
        GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ),
      );
      return userCredential.user;
    }
    return null;
  }

  Future createUserGoogleSignIn(MyUser user, [FirestoreDatabase? database]) async {
    database ??= FirestoreDatabase();
    if (! await database.userExists(user)) {
      await _createUser(user, database);
    }
  }
  Future<void> _createUser(MyUser user, [FirestoreDatabase? database]) async {
    database ??= FirestoreDatabase();
    final currentUser = auth.currentUser;
    if (currentUser == null) {
      throw Exception("User not logged in");
    }
    await database.createUser(user, currentUser.uid);
  }

  Future<void> registerUser(username, email, password, [FirestoreDatabase? database]) async {
    database ??= FirestoreDatabase();
    final UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user?.updateDisplayName(username);
    final user = MyUser(email: email, username: username, watched:[], toWatch:[], personalLists: []);
    await _createUser(user);
    return Future.value();
  }
}
