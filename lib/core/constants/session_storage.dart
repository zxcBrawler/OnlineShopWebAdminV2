import 'package:universal_html/html.dart';

class SessionStorage {
  static Storage sessionStorage = window.sessionStorage;

  static void saveLocalData(String key, String value) {
    sessionStorage[key] = value;
  }

  static String getValue(String key) {
    return sessionStorage[key] ?? '';
  }

  static void clearAll() {
    sessionStorage.clear();
  }
}
