import 'package:shared_preferences/shared_preferences.dart';

class LocaleStorage {
  /// Stores the explicit user-selected language code.
  /// When absent, the app-level fallback is Arabic.
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
