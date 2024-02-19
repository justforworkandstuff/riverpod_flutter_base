import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHandler {
  static SharedPreferences? _sharedPreferences;
  static const spAccessToken = 'accessToken';
  static const spRefreshToken = 'refreshToken';

  static Future<SharedPreferences> getSharedPreference() async {
    return _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  static void logout() {
    _sharedPreferences?.remove(spAccessToken);
    _sharedPreferences?.remove(spRefreshToken);
  }

  static void putAccessToken(String? token) {
    _sharedPreferences?.setString(spAccessToken, token ?? '');
  }

  static void putRefreshToken(String? token) {
    _sharedPreferences?.setString(spRefreshToken, token ?? '');
  }

  static String getAccessToken() {
    return _sharedPreferences?.getString(spAccessToken) ?? '';
  }

  static String getRefreshToken() {
    return _sharedPreferences?.getString(spRefreshToken) ?? '';
  }
}
