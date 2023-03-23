class UserModel {
  String id;
  final String username;
  final String email;

  UserModel({this.id = '', required this.username, required this.email});

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
  };
  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    username: json['username'],
    email: json['email'],
  );
}
