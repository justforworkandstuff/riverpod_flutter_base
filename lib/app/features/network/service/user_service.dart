import 'package:dumbdumb_flutter_app/app/common/model/my_response.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_general.dart';
import 'package:dumbdumb_flutter_app/app/features/network/model/user_model.dart';
import 'package:dumbdumb_flutter_app/app/features/network/providers/network_provider.dart';

/// Service is a class that helps in promoting the separation of concerns within the project
/// as separates out the business logic, data source and application handling from each other.
/// As we develop our app further, the project usually tends to get more and more complex,
/// and sometimes we may unknowingly add in the logic or requirements into the other layer.
/// With Service class, we will be able to avoid this concern as much as possible.
///
/// A sample use-case for Service class
/// Let's say we need to get different data from difference source of repository (e.g. UserRepository
/// and LoginRepository)
/// Making use of the Service class will help on cluttering the UserController with all sorts of business logic
/// which by right the controller should only handle the state changes of the presentation layer.

class UserService {
  UserService({required this.ref});

  final Ref ref;

  Future<UserModel> getUser() async {
    final response = await ref.read(userRepositoryProvider).getUser();
    if (response.status == ResponseStatus.complete &&
        response.data != null &&
        jsonDecode(response.data) is Map<String, dynamic>) {
      return UserModel.fromJson(jsonDecode(response.data));
    }
    // TODO: Think of a way to handle error state
    return const UserModel();
  }

  Future<void> putUserImage(String userImage) async {
    await ref.read(authRepositoryProvider).putUserImage(userImage);
  }

  String? getUserImage() {
    return ref.read(authRepositoryProvider).getUserImage();
  }
}
