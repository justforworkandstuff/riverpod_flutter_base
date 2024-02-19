import 'dart:convert';

import 'package:dumbdumb_flutter_app/app/features/network/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHandler {
  static SharedPreferences? _sharedPreferences;
  static const spUser = 'spUser';
  static const spAccessToken = 'spAccessToken';
  static const spRefreshToken = 'spRefreshToken';
  static const spUserImage = 'spUserImage';

  static Future<SharedPreferences> getSharedPreference() async {
    return _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  bool isLoggedIn() => getUser() != null;

  static void logout() {
    _sharedPreferences?.remove(spUser);
    _sharedPreferences?.remove(spAccessToken);
    _sharedPreferences?.remove(spRefreshToken);
    /// If we're sure that we can clear off everything, instead of removing the variables one by one,
    /// we can do it with the following line:
    // _sharedPreferences?.clear();
  }

  static void putUser(String user) {
    _sharedPreferences?.setString(spUser, user);
  }

  static UserModel? getUser() {
    try {
      final userInfo = _sharedPreferences?.getString(spUser) ?? '';

      if (userInfo.isNotEmpty) {
        final userMap = jsonDecode(userInfo) as Map<String, dynamic>;
        return UserModel.fromJson(userMap);
      }
      return null;
    } catch (e) {
      debugPrint('error: $e');
    }
    return null;
  }

  static void putAccessToken(String? token) {
    _sharedPreferences?.setString(spAccessToken, token ?? '');
  }

  static void putRefreshToken(String? token) {
    _sharedPreferences?.setString(spRefreshToken, token ?? '');
  }

  static void putUserImage(String? userImage) {
    _sharedPreferences?.setString(spUserImage, userImage ?? '');
  }

  static String getAccessToken() {
    return _sharedPreferences?.getString(spAccessToken) ?? '';
  }

  static String getRefreshToken() {
    return _sharedPreferences?.getString(spRefreshToken) ?? '';
  }

  static String getUserImage() {
    return _sharedPreferences?.getString(spUserImage) ?? '';
  }
}
