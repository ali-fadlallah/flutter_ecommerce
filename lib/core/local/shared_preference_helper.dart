import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static late SharedPreferences sharedPreference;
  static Future<void> init() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

  static Future<bool?> saveData({required String key, required dynamic value}) async {
    if (value is int) {
      return await sharedPreference.setInt(key, value);
    } else if (value is String) {
      return await sharedPreference.setString(key, value);
    } else if (value is bool) {
      return await sharedPreference.setBool(key, value);
    } else if (value is double) {
      return await sharedPreference.setDouble(key, value);
    } else if (value is List<String>) {
      return await sharedPreference.setStringList(key, value);
    }
    return null;
  }

  static Object? getData({required String key}) {
    return sharedPreference.get(key);
  }

  static Future<void> removeData({required String key}) {
    return sharedPreference.remove(key);
  }
}
