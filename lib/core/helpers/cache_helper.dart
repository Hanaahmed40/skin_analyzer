import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  // private constructor as I don't want to allow creating an instance of this class itself.
  CacheHelper._();

  /// Removes a value from SharedPreferences with given [key].
  static Future<bool> removeData(String key) async {
    debugPrint('SharedPrefHelper : data with key : $key has been removed');
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.remove(key);
  }

  /// Removes all keys and values in the SharedPreferences
  static Future<bool> clearAllData() async {
    debugPrint('SharedPrefHelper : all data has been cleared');
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }

  /// Saves a [value] with a [key] in the SharedPreferences.
  static Future<bool> setData(String key, value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    debugPrint("SharedPrefHelper : setData with key : $key and value : $value");
    switch (value.runtimeType) {
      case const (String):
        return await sharedPreferences.setString(key, value);
      case const (int):
        return await sharedPreferences.setInt(key, value);
      case const (bool):
        return await sharedPreferences.setBool(key, value);
      case const (double):
        return await sharedPreferences.setDouble(key, value);
      default:
        return false;
    }
  }

  /// Gets a bool value from SharedPreferences with given [key].
  static Future<bool?> getBool(String key) async {
    debugPrint('SharedPrefHelper : getBool with key : $key');
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }

  /// Gets a double value from SharedPreferences with given [key].
  static Future<double?> getDouble(String key) async {
    debugPrint('SharedPrefHelper : getDouble with key : $key');
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key);
  }

  /// Gets an int value from SharedPreferences with given [key].
  static Future<int?> getInt(String key) async {
    debugPrint('SharedPrefHelper : getInt with key : $key');
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key);
  }

  /// Gets an String value from SharedPreferences with given [key].
  static Future<String?> getString(String key) async {
    debugPrint('SharedPrefHelper : getString with key : $key');
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }
}
