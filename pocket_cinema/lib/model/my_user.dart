//TODO: save the user id
class MyUser {
  final String username;
  final String email;
  // Lists of media ids
  final List watched;
  final List toWatch;
  // List of list ids
  final List personalLists;

  MyUser({required this.username, required this.email, this.watched = const [], this.toWatch = const [], this.personalLists = const []});

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'watched': watched,
    'toWatch': toWatch,
    'lists': personalLists,
  };

  static MyUser fromJson(Map<String, dynamic> json) => MyUser(
    username: json['username'],
    email: json['email'],
    watched: json['watched'],
    toWatch: json['toWatch'],
    personalLists: json['personalLists'],
  );
}
