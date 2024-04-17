import 'package:dumbdumb_flutter_app/app/core/handlers/shared_preference_handler.dart';

class AuthRepository {
  /// Example two: Getting data from local source
  String? getUserImage() {
    return SharedPreferenceHandler.getUserImage();
  }

  /// Example three: Post data to local source
  Future<bool?> putUserImage(String userImage) async {
    return await SharedPreferenceHandler.putUserImage(userImage);
  }
}