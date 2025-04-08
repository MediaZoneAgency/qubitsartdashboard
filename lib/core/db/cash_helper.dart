import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Keys {
  guestMode,
  firstTime,
  userName,
  phoneNumber,
  token,
  darkMode,
  language,
  userImage,
  rideRequest,
  rideRequestID,
  couponID,
  couponAmount,
  lastTimeToLogin,
  counterOfLogin, email, otpValue, userId, secretKey,
}

class CashHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> putString(
      {required Keys key, required String value}) async {
    await sharedPreferences.setString(key.name, value);
  }

  static String? getString({required Keys key}) {
    return sharedPreferences.getString(key.name);
  }

  static Future<void> putInt({required Keys key, required int value}) async {
    await sharedPreferences.setInt(key.name, value);
  }

  static int? getInt({required Keys key}) {
    return sharedPreferences.getInt(key.name);
  }

  static Future<bool> remove({required Keys key}) {
    return sharedPreferences.remove(key.name);
  }

  static Future<void> putBool({required Keys key, required bool value}) async {
    await sharedPreferences.setBool(key.name, value);
  }

  static bool? getBool({required Keys key}) {
    return sharedPreferences.getBool(key.name);
  }

  static Future<void> putDouble(
      {required Keys key, required double value}) async {
    await sharedPreferences.setDouble(key.name, value);
  }

  static double? getDouble({required Keys key}) {
    return sharedPreferences.getDouble(key.name);
  }

  static bool? getMode() {
    return sharedPreferences.getBool(Keys.darkMode.name);
  }

  static Future<void> setStringScoured(
      {required Keys key, required String value}) async {
    const storage =FlutterSecureStorage();
    await storage.write(key: key.name, value: value);
  }

  static Future<String?> getStringScoured({required Keys key}) async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: key.name) ;
  }

  static Future<void> clear() async {
    final bool dark = CashHelper.getMode() ?? ThemeMode.system == ThemeMode.dark
        ? true
        : false;
    final language = getString(key: Keys.language);
    const storage = FlutterSecureStorage();
    storage.deleteAll();
    await sharedPreferences.clear();
    await sharedPreferences.setBool(Keys.firstTime.name, false);
    await sharedPreferences.setBool(Keys.darkMode.name, dark);
    await sharedPreferences.setString(Keys.language.name, language ?? "ar");
  }
}
