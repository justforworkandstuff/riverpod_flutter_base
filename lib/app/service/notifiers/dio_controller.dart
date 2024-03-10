import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dumbdumb_flutter_app/app/common/model/error_model.dart';
import 'package:dumbdumb_flutter_app/app/common/model/my_response.dart';
import 'package:dumbdumb_flutter_app/app/common/model/token_model.dart';
import 'package:dumbdumb_flutter_app/app/core/constants.dart';
import 'package:dumbdumb_flutter_app/app/core/enums.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_general.dart';
import 'package:dumbdumb_flutter_app/app/service/providers/app_options_providers.dart';
import 'package:dumbdumb_flutter_app/app/utils/shared_preference_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_controller.g.dart';

@Riverpod(keepAlive: true, dependencies: [currentFlavour])
class DioController extends _$DioController {
  @override
  Dio build() {
    final dioInstance = Dio(BaseOptions(headers: <String, String>{
      // 'Content-Type': ContentType.json.value,
      // if (authToken.isNotEmpty) 'Authorization': authToken
    }));

    dioInstance.interceptors.add(QueuedInterceptorsWrapper(onError: (error, handler) async {
      /// Access Token is considered expired when API return code 401/403
      /// Subject to change depends on backend configuration
      if (error.response?.statusCode == HttpErrorCode.unauthorized ||
          error.response?.statusCode == HttpErrorCode.forbidden) {
        try {
          // TODO: Re-add this
          // final dynamic responseRefreshToken = await _refreshTokenAPI();
          const dynamic responseRefreshToken = '';
          final options = error.response!.requestOptions;

          if (responseRefreshToken is bool) {
            // TODO: Re-add this
            // options.headers['Authorization'] = authToken;
            options.headers['Authorization'] = '';
          }

          await Dio().fetch<dynamic>(options).then((r) {
            return handler.resolve(r);
          }, onError: (e) => handler.reject(e));
        } catch (e) {
          if (e is DioException) {
            return handler.reject(e);
          }
        }
      }
      if (!handler.isCompleted) return handler.reject(error);
    }));

    return dioInstance;
  }

  Future<dynamic> _actionCallRefreshToken(String refreshTokenUrl) async {
    try {
      final response = await Dio().post<String>(
        refreshTokenUrl,
        // TODO: To readd this back
        options: Options(headers: <String, String>{'Authorization': 'refreshToken'}),
      );

      if (response.statusCode == HttpStatus.ok) {
        final tokenModel = TokenModel.fromJson(json.decode(response.data ?? '') as Map<String, dynamic>);

        SharedPreferenceHandler.putAccessToken(tokenModel.accessToken);
        SharedPreferenceHandler.putRefreshToken(tokenModel.refreshToken);
      }
      return response.statusCode == HttpStatus.ok;
    } catch (e) {
      if (e is DioException) {
        e.response?.data = ErrorModel(errorCode: e.response?.statusCode ?? HttpErrorCode.unhandledErrorCode,
            errorMessage: ErrorModel.fromJson(jsonDecode(e.response?.data)).errorMessage,
            errorCodeDescription: ErrorModel.fromJson(jsonDecode(e.response?.data)).errorCodeDescription,
            errorDescription: ErrorModel.fromJson(jsonDecode(e.response?.data)).error,
            error: e.error as String);
      }
      return e;
    }
  }

  /// Standardized api calling with try-catch block
  /// Respond with MyResponse object for consistent data/error handling in services layer
  /// Accessible by all inheriting classes
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
