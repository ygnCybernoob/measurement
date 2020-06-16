import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static Future<dynamic> get({String key}) async {
    final pref = await SharedPreferences.getInstance();
    return pref.get(key);
  }

  static Future<int> getInt({String key}) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }

  static Future<String> getString({String key}) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static Future<bool> setString({String key, String value}) async {
    final pref = await SharedPreferences.getInstance();
    return await pref.setString(key, value);
  }

  static Future<bool> setBool({String key, bool value}) async {
    final pref = await SharedPreferences.getInstance();
    return await pref.setBool(key, value);
  }

  static Future<bool> setInt({String key, int value}) async {
    final pref = await SharedPreferences.getInstance();
    return await pref.setInt(key, value);
  }
}
