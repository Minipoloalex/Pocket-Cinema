import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pocket_cinema/model/comment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mediaId = '123';
  const userId = '456';
  const username = 'John';
  const content = 'Great movie!';
  final createdAt = Timestamp.now();
  final comment = Comment(
    mediaID: mediaId,
    userId: userId,
    username: username,
    content: content,
    createdAt: createdAt,
  );
  test('CommentWidget toJson', () {
    final json = comment.toJson();
    expect(json['media_id'], mediaId);
    expect(json['user_id'], userId);
    expect(json['text'], content);
    expect(json['time_posted'], createdAt);
  });
}
