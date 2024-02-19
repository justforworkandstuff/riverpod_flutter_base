import 'package:dumbdumb_flutter_app/app/features/network/model/my_response.dart';

/// Repository class serves as an intermediary between the data source with the business logic.
/// It promotes the separation of concerns between data accessing logic and actual business logic
/// of the app.
/// Data sources that the Repository can take from could be either local or remote sources.
/// Local data sources: Local databases, Shared Preferences, Hive, and any data that is stored locally.
/// Remote data sources: REST API calls, Backend calls and so on.
/// Main purposed is to work as a data storage.

class UserRepository {
  // Future<MyResponse> login(String username, String password) async {
  //   return await _userServices.login(username, password);
  // }
  //
  // Future<MyResponse> getProfile() async {
  //   return await _userServices.getProfile();
  // }
}