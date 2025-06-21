import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const isLogin = "isLogin";
  static const userName = "userName";
  static const isQuestionScreen = "isQuestionScreen";
  static Future<void> save(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is Map<String, dynamic>) {
      final jsonString = jsonEncode(value);
      await prefs.setString(key, jsonString);
    } else {
      throw Exception('Unsupported type');
    }
  }

  static Future<dynamic> getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
