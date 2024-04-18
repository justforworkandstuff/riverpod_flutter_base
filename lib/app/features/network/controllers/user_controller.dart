import 'package:dumbdumb_flutter_app/app/features/network/model/user_model.dart';
import 'package:dumbdumb_flutter_app/app/features/network/providers/network_provider.dart';
import 'package:dumbdumb_flutter_app/app/features/network/service/user_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_controller.g.dart';

@riverpod
class UserController extends _$UserController {
  @override
  UserModel? build() {
    return null;
  }

  Future<void> getUser() async {
    final userService = ref.read(userServiceProvider);
    final userRepository = ref.read(userRepositoryProvider);
    final result = await userService.getUser(userRepository);
    state = result;
  }

  void getUserImage(UserService userService) async {
    final userImage = userService.getUserImage(ref.read(authRepositoryProvider));
    state = stateOrNull?.copyWith(profileImage: userImage);
  }
}
