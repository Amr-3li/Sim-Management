import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceSingelton {
  static late SharedPreferences _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();

    if (!_instance.containsKey('lang')) {
      await _instance.setString('lang', "en");
    }
  }

  static Future<bool> setBool(String key, bool value) =>
      _instance.setBool(key, value);

  static bool getBool(String key) => _instance.getBool(key) ?? false;

  static Future<void> setString(String key, String value) async {
    await _instance.setString(key, value);
  }

  static String? getString(String key) => _instance.getString(key);

  static Future<bool> remove(String key) => _instance.remove(key);
  static Future<bool> clear() => _instance.clear();
}
