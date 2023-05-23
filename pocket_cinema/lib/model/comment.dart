import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String content;
  Timestamp createdAt;
  String? username;
  String userId;
  String mediaID;

  Comment({
    this.username,
    required this.mediaID,
    required this.userId,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'media_id': mediaID,
      'user_id': userId,
      'text': content,
      'time_posted': createdAt,
    };
  }
}
