import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ─── String ──────────────────────────────────────────────────────────────

  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  String? getString(String key) => _prefs.getString(key);

  // ─── Int ─────────────────────────────────────────────────────────────────

  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);

  int? getInt(String key) => _prefs.getInt(key);

  // ─── Double ──────────────────────────────────────────────────────────────

  Future<bool> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);

  double? getDouble(String key) => _prefs.getDouble(key);

  // ─── Bool ────────────────────────────────────────────────────────────────

  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);

  bool? getBool(String key) => _prefs.getBool(key);

  // ─── List<String> ────────────────────────────────────────────────────────

  Future<bool> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);

  List<String>? getStringList(String key) => _prefs.getStringList(key);

  // ─── Utility ─────────────────────────────────────────────────────────────

  /// Returns `true` if [key] exists in storage.
  bool containsKey(String key) => _prefs.containsKey(key);

  /// Removes a single [key] from storage.
  Future<bool> remove(String key) => _prefs.remove(key);

  /// Removes all stored data. Use with caution.
  Future<bool> clear() => _prefs.clear();

  /// Returns every key currently stored.
  Set<String> getKeys() => _prefs.getKeys();
}
abstract class StorageKeys {
  StorageKeys._();

  // ─── Auth ─────────────────────────────────────────────────────────────────
  static const String authToken = 'auth_token';
}