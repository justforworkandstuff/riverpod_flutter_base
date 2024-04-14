import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dumbdumb_flutter_app/app/common/model/my_response_model.dart';
import 'package:dumbdumb_flutter_app/app/common/model/token_model.dart';
import 'package:dumbdumb_flutter_app/app/common/constants/constants.dart';
import 'package:dumbdumb_flutter_app/app/common/constants/enums.dart';
import 'package:dumbdumb_flutter_app/app/core/configurations/app_options_providers.dart';
import 'package:dumbdumb_flutter_app/app/core/handlers/shared_preference_handler.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_controller.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
class DioController extends _$DioController {
  Completer<String>? _refreshTokenCompleter;

  @override
  Dio build() {
    final dioInstance = Dio(ApiConstants.customOptions);
    dioInstance.interceptors.add(QueuedInterceptorsWrapper(onRequest: (options, handler) {
      if (options.headers.containsKey('Authorization') && SharedPreferenceHandler.getAccessToken().isNotEmpty) {
        options.headers['Authorization'] = 'Bearer ${SharedPreferenceHandler.getAccessToken()}';
      }
      return handler.next(options);
    }, onError: (error, handler) async {
      /// Access Token is considered expired when API return code 401/403
      /// Subject to change depends on backend configuration
      if (error.response?.statusCode == HttpErrorCode.unauthorized ||
          error.response?.statusCode == HttpErrorCode.forbidden) {
        try {
          final options = error.response!.requestOptions;
          final responseRefreshToken = await getNewTokens(ref.read(refreshTokenUrlProvider));

          /// Token update failed
          if (responseRefreshToken.isEmpty) {
            return handler.reject(error);
          }

          /// If token update success, proceed with requesting the api again
          options.headers['Authorization'] = 'Bearer ${SharedPreferenceHandler.getAccessToken()}';
          await Dio(ApiConstants.customOptions)
              .fetch(options)
              .then(handler.resolve)
              .catchError((e) => handler.reject(e));
        } catch (e) {
          return handler.reject(DioException(requestOptions: error.response!.requestOptions));
        }
      }
      if (!handler.isCompleted) return handler.reject(error);
    }));

    return dioInstance;
  }

  Future<String> getNewTokens(String refreshTokenUrl) async {
    if (_refreshTokenCompleter != null) return _refreshTokenCompleter!.future;

    final completer = _refreshTokenCompleter = Completer();
    try {
      final String token = await _actionCallRefreshToken(refreshTokenUrl);
      completer.complete(token);
      return token;
    } catch (ex, stacktrace) {
      completer.completeError(ex, stacktrace);
      return '';
    }
  }

  Future<String> _actionCallRefreshToken(String refreshTokenUrl) async {
    try {
      final response = await Dio(ApiConstants.customOptions).post<String>(
        refreshTokenUrl,
        options:
            Options(headers: <String, String>{'Authorization': 'Bearer ${SharedPreferenceHandler.getRefreshToken()}'}),
      );
      if (response.statusCode == HttpStatus.ok) {
        final tokenModel = TokenModel.fromJson(json.decode(response.data ?? '') as Map<String, dynamic>);
        SharedPreferenceHandler.putAccessToken(tokenModel.accessToken);
        SharedPreferenceHandler.putRefreshToken(tokenModel.refreshToken);
        return SharedPreferenceHandler.getAccessToken();
      }
      return '';
    } catch (e) {
      debugPrint('refreshToken: $e');
      return '';
    }
  }

  /// Standardized api calling with try-catch block
  /// Respond with MyResponse object for consistent data/error handling in services layer.
  Future<MyResponse> callAPI(HttpRequestType requestType, String path,
      {Map<String, dynamic>? postBody, Options? options}) async {
    try {
      stateOrNull?.options.contentType = Headers.jsonContentType;
      Response? response;

      switch (requestType) {
        case HttpRequestType.get:
          {
            response = await stateOrNull?.get(path);
          }
          break;
        case HttpRequestType.post:
          {
            response = await stateOrNull?.post(path, data: postBody);
          }
          break;
        case HttpRequestType.put:
          response = await stateOrNull?.put(path, data: postBody);
          break;
        case HttpRequestType.delete:
          response = await stateOrNull?.delete(path, data: postBody);
          break;
      }

      if (response?.statusCode == HttpStatus.ok) {
        return MyResponse.complete(jsonEncode(response?.data));
      }
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        return MyResponse.error(jsonEncode(e.response?.data));
      }
      return MyResponse.error(e);
    }
    return MyResponse.error(DioException(requestOptions: RequestOptions(path: path)));
  }
}
