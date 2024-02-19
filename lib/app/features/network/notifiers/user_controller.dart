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

  void getUser() async {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  void getUserImage() async {
    final UserService userService = UserService(ref: ref);
    final previousState = await future;

    /// Insert dummy network image to sharedPref, then retrieve it back later
    state = AsyncData(
        previousState?.copyWith(image: userService.getUserImage('https://randomuser.me/api/portraits/lego/7.jpg')));
  }
}
