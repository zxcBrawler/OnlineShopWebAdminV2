// Function to load accessToken from SharedPreferences
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveAccessToken(Map<String, String>? token) async {
    if (!isInitialized()) {
      throw Exception("SharedPreferencesManager not initialized.");
    }
    _prefs.setString('accessToken', token!.keys.first);
    _prefs.setString('username', token.values.first);
  }

  static Future<void> deleteAccessToken() async {
    if (!isInitialized()) {
      throw Exception("SharedPreferencesManager not initialized.");
    }
    _prefs.remove('accessToken');
  }

  static bool isInitialized() {
    return _prefs != null;
  }
}
