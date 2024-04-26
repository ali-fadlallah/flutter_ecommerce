import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static late SharedPreferences sharedPreference;
  static Future<void> init() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String token) async {
    await sharedPreference.setString('token', token);
  }

  static String getToken() {
    return sharedPreference.getString('token') ?? '';
  }

  static Future<void> clearToken() {
    return sharedPreference.remove('token');
  }
}
