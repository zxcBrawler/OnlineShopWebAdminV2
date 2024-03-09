// Function to load accessToken from SharedPreferences
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<String?> loadAccessToken() async {
    if (!isInitialized()) {
      throw Exception("SharedPreferencesManager not initialized.");
    }
    return _prefs.getString('accessToken');
  }

  static Future<void> saveAccessToken(String? token) async {
    if (!isInitialized()) {
      throw Exception("SharedPreferencesManager not initialized.");
    }
    _prefs.setString('accessToken', token ?? '');
  }

  static Future<void> deleteAccessToken() async {
    if (!isInitialized()) {
      throw Exception("SharedPreferencesManager not initialized.");
    }
    _prefs.remove('accessToken');
  }

  static bool isInitialized() {
    // ignore: unnecessary_null_comparison
    return _prefs != null;
  }
}
