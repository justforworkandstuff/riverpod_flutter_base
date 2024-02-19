import 'package:dumbdumb_flutter_app/app/features/network/model/user_model.dart';
import 'package:dumbdumb_flutter_app/app/utils/shared_preference_handler.dart';

/// Repository class serves as an intermediary between the data source with the business logic.
/// It promotes the separation of concerns between data accessing logic and actual business logic
/// of the app.
/// Data sources that the Repository can take from could be either local or remote sources.
/// Local data sources: Local databases, Shared Preferences, Hive, and any data that is stored locally.
/// Remote data sources: REST API calls, Backend calls and so on.
/// Main purposed is to work as a data storage and make modifications of data here
/// before returning it to controller.

class UserRepository {
  /// Example one: Getting data from remote sources
  Future<UserModel> getUser() async {
    /// Mock Api call delay
    await Future.delayed(const Duration(seconds: 3));

    return const UserModel(id: '1', name: 'Dummy User', age: 3);
  }
}
