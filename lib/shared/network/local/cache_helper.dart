import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static late SharedPreferences sharedpreferences;

  static init() async {
    sharedpreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putDataInSharedPreference({
    required bool mode,
    required String key,
  }) async {
    return await sharedpreferences.setBool(key, mode);
  }


  static bool? getDataFromSharedPreference({
    required String key,
  }) {
    return sharedpreferences.getBool(key);
  }
}
