import 'package:cloud_firestore/cloud_firestore.dart';

class CommentRepository {
  CommentRepository._();

  static final CommentRepository _instance = CommentRepository._();
  static CommentRepository get instance => _instance;

  final CollectionReference _commentCollection = FirebaseFirestore.instance.collection('comments');

  Stream<QuerySnapshot> getComments() {
    return _commentCollection
        .limit(15)
        .snapshots();
  }

  Stream<QuerySnapshot> getCommentsPage(DocumentSnapshot lastDoc) {
    return _commentCollection
        .startAfterDocument(lastDoc)
        .limit(15)
        .snapshots();
  }
}