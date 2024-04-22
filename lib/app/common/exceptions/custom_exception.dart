import 'dart:io';

import 'package:dumbdumb_flutter_app/app/common/model/error_model.dart';
import 'package:equatable/equatable.dart';

class CustomException extends Equatable implements Exception {
  const CustomException(this.error);

  final ErrorModel error;

  factory CustomException.unauthorised() {
    return const CustomException(ErrorModel(errorCode: HttpStatus.unauthorized, errorMessage: 'Unauthorised access'));
  }

  @override
  List<Object?> get props => [error];
}
