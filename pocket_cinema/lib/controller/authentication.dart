import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pocket_cinema/controller/validate.dart';
import 'package:pocket_cinema/model/my_user.dart';

import 'firestore_database.dart';

class Authentication {
  static Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
  static Future signIn(String user, String password) async {
    try {
      final email = Validate.isEmail(user) ? user : await FirestoreDatabase.getEmail(user);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
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

  static Future<User?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return Future.error("Sign in aborted by user");
    }

    final googleAuth = await googleUser.authentication;
    if (googleAuth.idToken != null) {
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ),
      );
      return userCredential.user;
    }
    return null;
  }

  static Future createUserGoogleSignIn(MyUser user) async {
    if (! await userExists(user)) {
      createUser(user);
    }
  }
  static Future<bool> userExists(MyUser user) async {
    return FirestoreDatabase.userExists(user);
  }
  static Future<void> createUser(MyUser user) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception("User not logged in");
    }
    await FirestoreDatabase.createUser(user, currentUser.uid);
  }

  static Future<void> registerUser(username, email, password) async {
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
      await value.user?.updateDisplayName(username);
      final user = MyUser(email: email, username: username, watched:[], toWatch:[], personalLists: []);
      await createUser(user);
      await Authentication.signIn(email, password);
    }).onError((error, stackTrace) => Future.error("Something went wrong"));
  }
}
