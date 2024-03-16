import 'package:dumbdumb_flutter_app/app/core/importers/importer_general.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_model.dart';
import 'package:dumbdumb_flutter_app/app/features/network/providers/network_provider.dart';

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
  UserService({required this.ref});

  final Ref ref;

  Future<dynamic> getUser() async {
    final response = await ref.read(userRepositoryProvider).getUser();
    if (response.status == ResponseStatus.complete &&
        response.data != null &&
        jsonDecode(response.data) is Map<String, dynamic>) {
      return UserModel.fromJson(jsonDecode(response.data));
    } else if (response.status == ResponseStatus.error && response.error != null) {
      throw CustomException(ErrorModel.fromJson(jsonDecode(response.error)));
    }
    throw CustomException(ErrorModel.unhandledError);
  }

  Future<void> putUserImage(String userImage) async {
    await ref.read(authRepositoryProvider).putUserImage(userImage);
  }

  String? getUserImage() {
    return ref.read(authRepositoryProvider).getUserImage();
  }

  // TODO: FOR REFRESH TOKEN FLOW REQUEST TESTING ONLY -------------------------
  Future<dynamic> getFirstApi() async {
    final response = await ref.read(userRepositoryProvider).getFirstApi();
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

  Future<dynamic> getSecondApi() async {
    final response = await ref.read(userRepositoryProvider).getSecondApi();
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

  Future<dynamic> putToken() async {
    final response = await ref.read(userRepositoryProvider).putToken();
    if (response.status == ResponseStatus.complete && response.data != null && response.data is bool) {
      return true;
    } else {
      return false;
    }
  }
  // TODO: REFRESH TOKEN FLOW REQUEST TESTING END -------------------------
}
