import 'package:dumbdumb_flutter_app/app/common/model/my_response.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_general.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_model.dart';
import 'package:dumbdumb_flutter_app/app/service/notifiers/dio_controller.dart';

/// Repository class serves as an intermediary between the data source with the business logic.
/// It promotes the separation of concerns between data accessing logic and actual business logic
/// of the app.
///
/// Data sources that the Repository can take from could be either local or remote sources.
/// Local data sources: Local databases, Shared Preferences, Hive, and any data that is stored locally.
/// Remote data sources: REST API calls, Backend calls and so on.
///
/// Main purposed is to work as a data storage.

class UserRepository {
  UserRepository({required this.ref});

  final Ref ref;

  /// Example one: Getting data from remote sources
  Future<MyResponse> getUser() async {
    /// Dummy API
    const path = 'https://jsonplaceholder.typicode.com/users/1';
    return await ref.read(dioControllerProvider.notifier).callAPI(HttpRequestType.get, path);
  }
}
