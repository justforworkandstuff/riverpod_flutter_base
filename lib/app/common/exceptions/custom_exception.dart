

import 'package:dumbdumb_flutter_app/app/common/model/error_model.dart';

class CustomException implements Exception {
  CustomException(this.error);

  final ErrorModel error;
}