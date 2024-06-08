import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

const String _kUidKey = 'UID';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static late SharedPreferences _preferences;

  SharedPreferencesService._();

  //   using a singleton patter
  static Future<SharedPreferencesService> getInstance() async {
    _instance ??= SharedPreferencesService._();
    _preferences = await SharedPreferences.getInstance();
    return _instance!;
  }

  //   perist and retrieve counter value
  String get uid => _getData(_kUidKey) ?? "";

  set uid(String value) => _saveData(_kUidKey, value);

  dynamic _getData(String key) {
    //   retrieve data from shared preferences
    var value = _preferences.get(key);

    //   easily log the data that we retrieve from shared preferences
    log('Retrieved $key : $value');

    //   return the data that we retrieve from shared preferences
    return value;
  }

  dynamic _saveData(String key, dynamic value) {
    //   easily log the data that we save to shared preferences
    log('Saving $key : $value');

    //   save the data to shared preferences
    if (value is String) {
      _preferences.setString(key, value);
    } else if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    }
  }
}
