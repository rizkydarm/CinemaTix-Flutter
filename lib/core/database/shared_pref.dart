part of '../_core.dart';

class SharedPrefHelper {

  SharedPreferences? _prefs;

  Future<SharedPrefHelper> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> setString(String key, String value) async {
    if (_prefs == null) {
      throw Exception('SharedPreferences is not initialized');
    }
    await _prefs!.setString(key, value);
  }

  Future<void> setMap(String key, Map<String, dynamic> value) async {
    if (_prefs == null) {
      throw Exception('SharedPreferences is not initialized');
    }
    String jsonString = jsonEncode(value);
    await _prefs!.setString(key, jsonString);
  }

  Future<Map<String, dynamic>> getMap(String key) async {
    if (_prefs == null) {
      throw Exception('SharedPreferences is not initialized');
    }
    String? jsonString = _prefs!.getString(key);
    if (jsonString == null) {
      throw Exception('Data is not found');
    }
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  Future<void> removeMap(String key) async {
    if (_prefs == null) {
      throw Exception('SharedPreferences is not initialized');
    }
    await _prefs!.remove(key);
  }

}