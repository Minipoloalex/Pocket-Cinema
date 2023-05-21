import 'package:pocket_cinema/controller/firestore_database.dart';

class Validate {
  static bool isEmail(String email){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  }

  static Future<String> login(String userId, String password, [FirestoreDatabase? database]) async {
    database ??= FirestoreDatabase();
    if (userId.isEmpty) {
      return Future.error("Please enter your email or username");
    }
    if (password.isEmpty) {
      return Future.error("Please enter your password");
    } 
    if(!isEmail(userId)){
      if(!await database.usernameExists(userId)){
        return Future.error("The username does not exist");
      }
    }else{
      if(!await database.emailExists(userId)){
        return Future.error("The email does not exist");
      }
    }
    return "";
  }

  static Future<String> register(String username, String email, String password, String confirmPassword, [FirestoreDatabase? database]) async{
    database ??= FirestoreDatabase();
    if(username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      return Future.error("There are empty fields");
    }
    if(!isEmail(email)) {
      return Future.error("Please enter a valid email");
    }
    if(password.length < 6) {
      return Future.error("Password must be at least 6 characters");
    }
    if(password != confirmPassword) {
      return Future.error("Passwords do not match");
    }
    if(await database.emailExists(email)){
      return Future.error("The email already exists");
    }
    if(await database.usernameExists(username)){
      return Future.error("The username already exists");
    }

    return "";
  }
  static bool listName(String listName) {
    return listName.length >= 2 && listName.length <= 20;
  }
}
