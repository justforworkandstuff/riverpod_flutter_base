import 'package:dumbdumb_flutter_app/app/utils/shared_preference_handler.dart';

class AuthRepository {
  /// Example two: Getting data from local source
  String? getUserImage() {
    return SharedPreferenceHandler.getUserImage();
  }
}