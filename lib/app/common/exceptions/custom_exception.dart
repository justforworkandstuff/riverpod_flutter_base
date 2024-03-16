import 'package:dumbdumb_flutter_app/app/core/importers/importer_model.dart';

class CustomException implements Exception {
  CustomException(this.error);

  final ErrorModel error;
}