class MyUser {
  String id;
  final String? username;
  final String? email;

  MyUser({this.id = '', required this.username, required this.email});

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
  };
  static MyUser fromJson(Map<String, dynamic> json) => MyUser(
    id: json['id'],
    username: json['username'],
    email: json['email'],
  );
}
