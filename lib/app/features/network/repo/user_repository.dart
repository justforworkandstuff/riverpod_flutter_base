import 'package:dumbdumb_flutter_app/app/common/model/my_response.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_general.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_model.dart';
import 'package:dumbdumb_flutter_app/app/features/network/model/user_model.dart';
import 'package:dumbdumb_flutter_app/app/service/notifiers/dio_controller.dart';

/// Repository class serves as an intermediary between the data source with the business logic.
/// It promotes the separation of concerns between data accessing logic and actual business logic
/// of the app.
/// Data sources that the Repository can take from could be either local or remote sources.
/// Local data sources: Local databases, Shared Preferences, Hive, and any data that is stored locally.
/// Remote data sources: REST API calls, Backend calls and so on.
/// Main purposed is to work as a data storage and make modifications of data here
/// before returning it to controller.

class UserRepository {
  UserRepository({required this.ref});

  final Ref ref;

  /// Example one: Getting data from remote sources
  Future<UserModel> getUser() async {
    /// Dummy API
    const path = 'https://jsonplaceholder.typicode.com/users/1';
    final response = await ref.read(dioControllerProvider.notifier).callAPI(HttpRequestType.get, path);

    if (response.status == ResponseStatus.complete &&
        response.data != null &&
        jsonDecode(response.data) is Map<String, dynamic>) {
      return UserModel.fromJson(jsonDecode(response.data));
    }
    // TODO: Think of a way to handle error state
    return const UserModel();
  }
}
