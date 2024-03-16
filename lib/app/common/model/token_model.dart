import 'package:dumbdumb_flutter_app/app/core/util.dart';

class TokenModel {

  TokenModel({this.accessToken, this.refreshToken});

  TokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = DynamicParsing(json['accessToken']).parseString();
    refreshToken = DynamicParsing(json['refreshToken']).parseString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }

  String? accessToken;
  String? refreshToken;
}
