//TODO: save the user id
class MyUser {
  final String? username;
  final String? email;

  MyUser({required this.username, required this.email});

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
  };
  static MyUser fromJson(Map<String, dynamic> json) => MyUser(
    username: json['username'],
    email: json['email'],
  );
}
