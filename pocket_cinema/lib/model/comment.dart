class Comment {
  String content;
  String userID;
  DateTime createdAt;

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
      createdAt: DateTime.parse(json['time_posted']),
    );
  }
}
