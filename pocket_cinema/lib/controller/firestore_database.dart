import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pocket_cinema/model/comment.dart';


class FirestoreDatabase {
  static Future<String> getEmail(String username) async {
    final usersRef = FirebaseFirestore.instance.collection('users');
    QuerySnapshot snapshot = await usersRef.where("username", isEqualTo: username).get();
    if (snapshot.docs.isNotEmpty) {
      String email = snapshot.docs.first.get('email');
      return email;
    }
    return "User not found";
  }

  static bool isEmail(String str) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(str);
  }

  static void addComment(String mediaId, String text, String userId) {
    final commentsRef = FirebaseFirestore.instance.collection('comments');
    commentsRef.add(
        Comment(
          mediaID: mediaId,
          content: text,
          userID: userId,
          createdAt: DateTime.now(),
        ).toJson()
    );
  }

  static Future<List<Comment>> getComments(String mediaId) async {
    final commentsRef = FirebaseFirestore.instance.collection('comments');
    final commentSnapshot = await commentsRef.where("media_id", isEqualTo: mediaId).get();
    final List<QueryDocumentSnapshot> commentDocs = commentSnapshot.docs;

    List<Comment> comments = commentDocs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Comment.fromJson(data);
    }).toList();
    return comments;
  }
}
