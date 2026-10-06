import 'package:shared_preferences/shared_preferences.dart';

class HSharedPreferences {
  late final SharedPreferences prefs;

  HSharedPreferences._privateConstructor();
  static final HSharedPreferences instance = HSharedPreferences._privateConstructor();

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    return await prefs.setString(key, value);
  }

  String? getString(String key) {
    return prefs.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return prefs.getBool(key);
  }

  Future<bool> setInt(String key, int value) async {
    return await prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return prefs.getInt(key);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return await prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return prefs.getStringList(key);
  }

  Future<void> clearAllData() async {
    await prefs.clear();
  }

  Future<bool> deleteData(String key) async {
    return await prefs.remove(key);
  }
}
