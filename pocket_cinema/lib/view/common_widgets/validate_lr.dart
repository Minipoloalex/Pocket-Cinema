

class ValidateLR {
  static String? validateLogin(String? userId, String? password) {
    if (userId == null || userId.isEmpty) {
      return 'Please enter your email or username';
    }
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  static String? validateRegister(String? username, String? email, String? password, String? confirmPassword) {
    if (email != null && email.isNotEmpty) {
      final RegExp emailRegex = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
      if (!emailRegex.hasMatch(email)) {
        return 'Please enter a valid email';
      }
    }
    if (email == null || email.isEmpty) {
      return 'Please enter your email';
    }
    if (username == null || username.isEmpty) {
      return 'Please enter your username';
    }
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}