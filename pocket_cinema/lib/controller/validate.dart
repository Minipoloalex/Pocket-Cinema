import 'package:pocket_cinema/controller/authentication.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:pocket_cinema/model/my_user.dart';

class Validate {
  static bool isEmail(String email){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  }

  static Future<String> login(String userId, String password) async{
    if (userId.isEmpty) {
      Future.error("Please enter your email or username");
    }
    if (password.isEmpty) {
      Future.error("Please enter your password");
    } 
    if (!await Authentication.userExists(MyUser(username,email)) || !getEmail(username)) {
      Future.error("User does not exist");
    }
    if (!await Authentication.passwordMatches(user)) {
      Future.error("Password does not match");
    }
    return "";
  }

  static Future<String> register(String username, String email, String password, String confirmPassword) async{
    if(username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Future.error("There are empty fields");
    }
    if(!isEmail(email)) {
      Future.error("Please enter a valid email");
    }
    if(password.length < 6) {
      Future.error("Password must be at least 6 characters");
    }
    if(password != confirmPassword) {
      Future.error("Passwords do not match");
    }
    if(await FirestoreDatabase.emailExists(email)){
      Future.error("The email already exists");
    }
    if(await FirestoreDatabase.usernameExists(username)){
      Future.error("The username already exists");
    }

    return "";
  }
}