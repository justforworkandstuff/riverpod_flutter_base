import 'package:dumbdumb_flutter_app/app/features/network/model/user_model.dart';
import 'package:dumbdumb_flutter_app/app/features/network/service/user_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_controller.g.dart';

@riverpod
class UserController extends _$UserController {
  @override
  FutureOr<UserModel?> build() async {
    final UserService userService = UserService(ref: ref);
    return await userService.getUser();
  }

  void getUser() {

  }

  void getUserImage() {

  }
}
