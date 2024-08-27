import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  static Future<void> saveUser({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', lastName);
    await prefs.setString('password', password);
  }

  static Future<Map<String, String>?> getUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('email');
    if (storedEmail == email || email.isEmpty) {
      return {
        'email': storedEmail!,
        'firstName': prefs.getString('firstName') ?? '',
        'lastName': prefs.getString('lastName') ?? '',
        'password': prefs.getString('password') ?? '',
      };
    }
    return null;
  }
}
