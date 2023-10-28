import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesStorage {
  Future<bool> setStringList(String key, List<String> values);

  List<String>? getStringList(String key);
}

class PreferencesStorageImpl implements PreferencesStorage {
  final SharedPreferences sharedPreferences;

  PreferencesStorageImpl({
    required this.sharedPreferences,
  });

  @override
  Future<bool> setStringList(String key, List<String> values) {
    return sharedPreferences.setStringList(key, values);
  }

  @override
  List<String>? getStringList(String key) {
    return sharedPreferences.getStringList(key);
  }
}
