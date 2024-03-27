import 'package:universal_html/html.dart';

// Session storage class for storing different data in browser tab
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
