import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageUtils {
  static StorageUtils? _instance;
  static bool isShow = false;
  static const _secureStorage = FlutterSecureStorage();
  StorageUtils._();
  factory StorageUtils() {
    _instance ??= StorageUtils._();
    return _instance!;
  }
  // put string
  static Future<void> putString(String key, String value) {
    return _secureStorage.write(key: key, value: value);
  }

  // get string
  static Future<String> getString(String key, {String defValue = ''}) async {
    return await _secureStorage.read(key: key) ?? defValue;
  }

  // put int
  static Future<void> putInt(String key, int value) {
    return _secureStorage.write(key: key, value: "$value");
  }

  // get int
  static Future<int> getInt(String key, {int defValue = 0}) async {
    return int.parse(
        await _secureStorage.read(key: key) ?? defValue.toString());
  }

  // put double
  static Future<void> putDouble(String key, double value) {
    return _secureStorage.write(key: key, value: "$value");
  }

  // get double
  static Future<double> getDouble(String key, {double defValue = 0.0}) async {
    return double.parse(
        await _secureStorage.read(key: key) ?? defValue.toString());
  }

  // put bool
  static Future<void> putBool(String key, bool value) {
    return _secureStorage.write(key: key, value: "$value");
  }

  // get bool
  static Future<bool> getBool(String key, {bool defValue = false}) async {
    return bool.parse(await _secureStorage.read(key: key) ?? "$defValue",
        caseSensitive: false);
  }

//put obj
  // static Future<void> putModel(String key, Map<String, dynamic> value) {
  //   return _secureStorage.write(key: key, value: jsonEncode(value));
  // }

  // clear string
  static Future<void> deleteData(String key) {
    return _secureStorage.delete(key: key);
  }
}
