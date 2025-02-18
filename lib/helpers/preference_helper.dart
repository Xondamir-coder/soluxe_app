import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static Future<SharedPreferences> get _prefs =>
      SharedPreferences.getInstance();

  // ✅ Theme
  static Future<void> saveTheme(bool isDark) async {
    final prefs = await _prefs;
    await prefs.setBool('isDark', isDark);
  }

  static Future<bool> getTheme() async {
    final prefs = await _prefs;
    return prefs.getBool('isDark') ?? false;
  }

  // ✅ Language
  static Future<void> saveLanguage(String langCode) async {
    final prefs = await _prefs;
    await prefs.setString('lang', langCode);
  }

  static Future<String> getLanguage() async {
    final prefs = await _prefs;
    return prefs.getString('lang') ?? 'en';
  }

  // ✅ Get alert in your phone
  static Future<void> saveAlertPhone(bool alertPhone) async {
    final prefs = await _prefs;
    await prefs.setBool('alertPhone', alertPhone);
  }

  static Future<bool> getAlertPhone() async {
    final prefs = await _prefs;
    return prefs.getBool('alertPhone') ?? false;
  }

  // ✅ Get alert in your email
  static Future<void> saveAlertEmail(bool alertEmail) async {
    final prefs = await _prefs;
    await prefs.setBool('alertEmail', alertEmail);
  }

  static Future<bool> getAlertEmail() async {
    final prefs = await _prefs;
    return prefs.getBool('alertEmail') ?? false;
  }

  // ✅ Get alert in your phone
  static Future<void> saveNewsletter(bool newsletter) async {
    final prefs = await _prefs;
    await prefs.setBool('newsletter', newsletter);
  }

  static Future<bool> getNewsletter() async {
    final prefs = await _prefs;
    return prefs.getBool('newsletter') ?? false;
  }
}
