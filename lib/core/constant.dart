import 'package:shared_preferences/shared_preferences.dart';

class AppUrls {
  static const String newsAPIBaseURL = 'http://test.abhtechnology.com/api';

  static Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  static Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token").toString();
  }
}
