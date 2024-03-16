import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dumbdumb_flutter_app/app/utils/shared_preference_handler.dart';

class HttpErrorCode {
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int unhandledErrorCode = 999;
}

class ApiConstants {
  static final customOptions = BaseOptions(headers: <String, String>{
    'Content-Type': ContentType.json.value,
    if (SharedPreferenceHandler.getAccessToken().isNotEmpty)
      'Authorization': 'Bearer ${SharedPreferenceHandler.getAccessToken()}'
  });
}