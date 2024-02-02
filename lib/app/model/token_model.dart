import 'package:dumbdumb_flutter_app/app/utils/util.dart';

class TokenModel {

  TokenModel({this.accessToken, this.refreshToken});

  TokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = DynamicParsing(json['auth_token']).parseString();
    refreshToken = DynamicParsing(json['refresh_token']).parseString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auth_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    return data;
  }

  String? accessToken;
  String? refreshToken;
}
