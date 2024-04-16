import 'package:dumbdumb_flutter_app/app/core/util.dart';

class SuccessModel {

  SuccessModel({this.success});

  SuccessModel.fromJson(Map<String, dynamic> json) {
    success = DynamicParsing(json['success']).parseBool();
  }

  bool? success;
}