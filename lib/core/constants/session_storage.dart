import 'package:universal_html/html.dart';

class SessionStorage {
  static Storage sessionStorage = window.sessionStorage;

  static void saveLocalData<T>(String key, T value) {
    sessionStorage[key] = value.toString();
  }

  static String getValue(String key) {
    return sessionStorage[key] ?? '';
  }

  static void clearAll() {
    sessionStorage.clear();
  }
}
