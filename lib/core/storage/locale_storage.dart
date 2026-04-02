import 'package:shared_preferences/shared_preferences.dart';

class LocaleStorage {
  static const _key = 'preferred_language_code';

  Future<String?> read() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_key);
  }

  Future<void> write(String code) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_key, code);
  }
}
