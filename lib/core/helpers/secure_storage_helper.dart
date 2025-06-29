import 'dart:developer' show log;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  SecureStorageHelper._();

  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  static Future<void> setSecuredString(String key, String value) async {
    const flutterSecureStorage = FlutterSecureStorage();
    log(
      "FlutterSecureStorage : setSecuredString with key : $key and value : $value",
    );
    return await flutterSecureStorage.write(key: key, value: value);
  }

  /// Gets an String value from FlutterSecureStorage with given [key].
  static Future<String> getSecuredString(String key) async {
    const flutterSecureStorage = FlutterSecureStorage();
    log('FlutterSecureStorage : getSecuredString with $key :');
    return await flutterSecureStorage.read(key: key) ?? '';
  }

  /// Removes a value from FlutterSecureStorage with given [key].
  static Future<void> removeSecuredData(String key) async {
    log('FlutterSecureStorage : data with key : $key has been removed');
    const flutterSecureStorage = FlutterSecureStorage();
    return await flutterSecureStorage.delete(key: key);
  }

  /// Removes all keys and values in the FlutterSecureStorage
  static Future<void> clearAllSecuredData() async {
    log('FlutterSecureStorage : all data has been cleared');
    const flutterSecureStorage = FlutterSecureStorage();
    return await flutterSecureStorage.deleteAll();
  }
}
