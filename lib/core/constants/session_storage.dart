import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

// Session storage class for storing different data in browser tab

//languages code
const String en = 'en';
const String ru = 'ru';

class SessionStorage {
  static Storage sessionStorage = window.sessionStorage;

  static void saveLocalData<T>(String key, T value) {
    sessionStorage[key] = value.toString();
  }

  static Future<Locale> setLocale(String languageCode) async {
    sessionStorage["language"] = languageCode;
    return _locale(languageCode);
  }

  static Future<Locale> getLocale() async {
    String languageCode = sessionStorage["language"] ?? 'ru';
    return _locale(languageCode);
  }

  static String getValue(String key) {
    return sessionStorage[key] ?? '';
  }

  static void clearAll() {
    sessionStorage.clear();
  }

  static Locale _locale(String languageCode) {
    switch (languageCode) {
      case en:
        return const Locale(en, '');
      case ru:
        return const Locale(ru, "");
      default:
        return const Locale(en, '');
    }
  }
}
