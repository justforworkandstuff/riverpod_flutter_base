import 'dart:convert';

import 'package:dumbdumb_flutter_app/app/common/exceptions/custom_exception.dart';
import 'package:dumbdumb_flutter_app/app/common/model/error_model.dart';
import 'package:dumbdumb_flutter_app/app/common/model/my_response_model.dart';
import 'package:dumbdumb_flutter_app/app/features/network/model/user_model.dart';
import 'package:dumbdumb_flutter_app/app/features/network/repo/auth_repository.dart';
import 'package:dumbdumb_flutter_app/app/features/network/repo/user_repository.dart';
import 'package:mocktail/mocktail.dart';

/// Service is a class that helps in promoting the separation of concerns within the project
/// as separates out the business logic and data source from each other.
/// As we develop our app further, the project usually tends to get more and more complex,
/// and sometimes we may unknowingly add in the logic or requirements into the other layer.
/// With Service class, we will be able to avoid this concern as much as possible.
///
/// A sample use-case for Service class
/// Let's say we need to get different data from difference source of repository (e.g. UserRepository
/// and LoginRepository)
/// Making use of the Service class will help on de-cluttering the UserController with all sorts of business logic
/// which by right the controller should only handle the state changes of the presentation layer.
class UserService {
  Future<dynamic> getUser(UserRepository userRepository) async {
    final response = await userRepository.getUser();
    if (response.status == ResponseStatus.complete &&
        response.data != null &&
        jsonDecode(response.data) is Map<String, dynamic>) {
      return UserModel.fromJson(jsonDecode(response.data));
    } else if (response.status == ResponseStatus.error &&
        response.error is String &&
        jsonDecode(response.error) is Map<String, dynamic>) {
      throw CustomException(ErrorModel.fromJson(jsonDecode(response.error)));
    }
    throw CustomException(ErrorModel.unhandledError);
  }

  Future<void> putUserImage(AuthRepository authRepository, String userImage) async {
    await authRepository.putUserImage(userImage);
  }

  String? getUserImage(AuthRepository authRepository) {
    return authRepository.getUserImage();
  }

  // TODO: FOR REFRESH TOKEN FLOW REQUEST TESTING ONLY -------------------------
  Future<dynamic> getFirstApi(UserRepository userRepository) async {
    final response = await userRepository.getFirstApi();
    if (response.status == ResponseStatus.complete &&
        response.data != null &&
        jsonDecode(response.data) is Map<String, dynamic>) {
      // The actual return items doesn't matter
      return '';
    } else if (response.status == ResponseStatus.error && response.error != null) {
      throw CustomException(ErrorModel.fromJson(jsonDecode(response.error)));
    }
    throw CustomException(ErrorModel.unhandledError);
  }

  Future<dynamic> getSecondApi(UserRepository userRepository) async {
    final response = await userRepository.getSecondApi();
    if (response.status == ResponseStatus.complete &&
        response.data != null &&
        jsonDecode(response.data) is Map<String, dynamic>) {
      // The actual return items doesn't matter
      return '';
    } else if (response.status == ResponseStatus.error && response.error != null) {
      throw CustomException(ErrorModel.fromJson(jsonDecode(response.error)));
    }
    throw CustomException(ErrorModel.unhandledError);
  }

  Future<dynamic> putToken(UserRepository userRepository) async {
    final response = await userRepository.putToken();
    if (response.status == ResponseStatus.complete && response.data != null && response.data is bool) {
      return true;
    } else {
      return false;
    }
  }
// TODO: REFRESH TOKEN FLOW REQUEST TESTING END -------------------------
}

/// For unit testing purposes
class MockUserService extends Mock implements UserService {}
