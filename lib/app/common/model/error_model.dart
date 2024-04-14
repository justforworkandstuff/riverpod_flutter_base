import 'package:dumbdumb_flutter_app/app/common/constants/constants.dart';
import 'package:dumbdumb_flutter_app/generated/l10n.dart';

class ErrorModel {
  const ErrorModel(
      {required this.errorCode, this.errorMessage, this.errorCodeDescription, this.error, this.errorDescription});

  static ErrorModel unhandledError =
  ErrorModel(errorCode: HttpErrorCode.unhandledErrorCode, errorMessage: S.current.generalError);

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
        errorCode: int.tryParse(json['statusCode'].toString()) ?? 0,
        errorMessage: json['message'] != null ? json['message'].toString() : '',
        errorCodeDescription: json['errorCode'] != null ? json['errorCode'].toString() : '',
        error: json['error'] != null ? json['error'].toString() : '',
        errorDescription: json['errorDescription'] != null ? json['errorDescription'].toString() : '');
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'statusCode': errorCode,
      'message': errorMessage,
      'errorCode': errorCodeDescription,
      'error': error,
      'errorDescription': errorDescription
    };
  }

  String? getErrorMessageTitle() {
    if (errorCodeDescription?.isNotEmpty == true) {
      return errorCodeDescription;
    } else if (error?.isNotEmpty == true) {
      return error;
    }
    return null;
  }

  String? getErrorMessage() {
    if (errorMessage?.isNotEmpty == true) {
      return errorMessage;
    } else if (errorDescription?.isNotEmpty == true) {
      return errorDescription;
    }
    return null;
  }

  final int? errorCode;

  /// Error from api response failure
  final String? errorMessage;
  final String? errorCodeDescription;

  /// Error from server common failure
  final String? error;
  final String? errorDescription;

  bool forbidden() => errorCode == HttpErrorCode.unauthorized || errorCode == HttpErrorCode.forbidden;

  @override
  String toString() => '${getErrorMessageTitle()}: ${getErrorMessage()}';
}
