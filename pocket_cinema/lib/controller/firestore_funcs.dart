import 'package:cloud_firestore/cloud_firestore.dart';


Future<String> getEmail(String username) async {
  final usersRef = FirebaseFirestore.instance.collection('users');
  QuerySnapshot snapshot = await usersRef.where("username", isEqualTo: username).get();
  if (snapshot.docs.isNotEmpty) {
    String email = snapshot.docs.first.get('email');
    return email;
  }
  return "User not found";
}

bool isEmail(String str) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(str);
}
