import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Preferences._();

  static const String isLoggedIn = "isLoggedIn";
  static const String userInfo = "userInfo";
  static const String userId = "userId";
  static const String userType = "userType";
  static const String userName = "userName";
  static const String userEmail = "userEmail";
  static const String isSplash = "isSplash";
  static const String currentNavigation = "currentNavigation";
  static const String isOnBoarding = "isOnBoarding";
  static const String isOnLine = "isOnLine";
  static const String authToken = "authToken";
}

class StorageHelper {
  StorageHelper._();

  static SharedPreferences? _prefs;

  static Future<dynamic> _getInstance() async =>
      _prefs = await SharedPreferences.getInstance();

  static Future<String> get(String key) async {
    await _getInstance();
    var response = _prefs!.getString(key);
    response = response ?? "";
    return response;
    // return _prefs!.getString(key)!;
  }

  static void set(String key, dynamic value) async {
    await _getInstance();
    _prefs!.setString(key, value);
  }

  static void remove(String key) async {
    await _getInstance();
    _prefs!.remove(key);
  }

  static void clearAll() async {
    await _getInstance();
    _prefs!.clear();
  }

  static void setBool(String key, dynamic value) async {
    await _getInstance();
    _prefs!.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    await _getInstance();
    return _prefs!.getBool(key)!;
    // var response = _prefs.getBool(key);
    // return response;
  }
}
