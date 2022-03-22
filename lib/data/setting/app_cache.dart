import 'package:shared_preferences/shared_preferences.dart';

class AppCache{
  static const kToken = 'token';

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kToken, token);
  }
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
   return await prefs.getString(kToken);
  }
}