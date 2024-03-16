import 'package:dumbdumb_flutter_app/app/core/importers/importer_model.dart';
import 'package:dumbdumb_flutter_app/app/features/network/service/user_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_controller_with_refresh_token_flow.g.dart';

@riverpod
class UserControllerWithRefreshTokenFlow extends _$UserControllerWithRefreshTokenFlow {
  @override
  FutureOr<UserModel?> build() async {
    final UserService userService = UserService(ref: ref);
    await userService.putUserImage('https://randomuser.me/api/portraits/lego/7.jpg');
    // TODO: Enable these for refresh token flow request testing
    // 1. Insert token to simulate already login status as per production
    // 2. Perform multiple api calls simultaneously under accessToken expired status
    // 3. Observe result of the api calls through Flutter DevTools
    //
    // Expected api call flow would be:
    // 1. Api 1 (401 error with customized error from putToken() method)
    // 2. Api 2 (401 error with customized error from putToken() method)
    // 3. Refresh token api (200 success)
    // 4. Api 1 (200 success with new accessToken)
    // 5. Api 2 (200 success with new accessToken)
    // ------- Uncomment these to test the flow --------
    // await userService.putToken();
    // await Future.wait([
    //   userService.getFirstApi(),
    //   userService.getSecondApi(),
    // ]);
    // ------- End --------
    return await userService.getUser();
  }

  void getUser() async {
    /// Will mark current state as dirty and recall build() method's actions
    ref.invalidateSelf();
  }

  void getUserImage() async {
    final UserService userService = UserService(ref: ref);
    final previousState = await future;

    /// Insert dummy network image to sharedPref, then retrieve it back later
    state = AsyncData(previousState?.copyWith(profileImage: userService.getUserImage()));
  }
}
