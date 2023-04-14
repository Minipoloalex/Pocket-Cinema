import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String content;
  String userID;
  Timestamp createdAt;

  String? mediaID;

  Comment({
    this.mediaID,
    required this.content,
    required this.userID,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'media_id': mediaID,
      'user_id': userID,
      'text': content,
      'time_posted': createdAt,
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      content: json['text'],
      userID: json['user_id'],
      createdAt: json['time_posted'],
    );
  }
}
