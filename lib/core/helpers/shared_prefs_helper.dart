import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  SharedPrefsHelper._();
  static SharedPreferences? _prefs;

  static const String _fcmTokenKey = 'fcm_token';
  static const String _notificationsEnabledKey = 'notifications_enabled';
  static const String _themeKey = 'app_theme_mode';

  // 1. Initialize SharedPreferences once at startup
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setFcmToken(String token) async {
    await _prefs?.setString(_fcmTokenKey, token);
  }

  static Future<String?> getFcmToken() async {
    return _prefs?.getString(_fcmTokenKey);
  }

  static Future<void> clearFcmToken() async {
    await _prefs?.remove(_fcmTokenKey);
  }

  static Future<void> setNotificationsEnabled(bool enabled) async {
    await _prefs?.setBool(_notificationsEnabledKey, enabled);
  }

  static bool getNotificationsEnabled() {
    return _prefs?.getBool(_notificationsEnabledKey) ?? true;
  }

  // 5. Theme preference
  static Future<void> setThemeMode(String mode) async {
    await _prefs?.setString(_themeKey, mode);
  }

  static String? getThemeMode() {
    return _prefs?.getString(_themeKey);
  }
}
