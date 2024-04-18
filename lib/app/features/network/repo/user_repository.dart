import 'package:dumbdumb_flutter_app/app/common/constants/enums.dart';
import 'package:dumbdumb_flutter_app/app/common/model/my_response_model.dart';
import 'package:dumbdumb_flutter_app/app/core/dio/dio_controller.dart';
import 'package:dumbdumb_flutter_app/app/core/handlers/shared_preference_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

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

  // TODO: FOR REFRESH TOKEN FLOW REQUEST TESTING ONLY -------------------------
  Future<MyResponse> getFirstApi() async {
    // TODO: Insert API #1 path used for testing
    const path = '';
    return await ref.read(dioControllerProvider.notifier).callAPI(HttpRequestType.get, path);
  }

  Future<MyResponse> getSecondApi() async {
    // TODO: Insert API #2 path used for testing
    const path = '';
    return await ref.read(dioControllerProvider.notifier).callAPI(HttpRequestType.get, path);
  }

  // Put token to override simulate already login status
  Future<MyResponse> putToken() async {
    final result = await Future.wait(
        [SharedPreferenceHandler.putAccessToken('/1234'), SharedPreferenceHandler.putRefreshToken('')]);
    return !result.contains(false) ? MyResponse.complete(true) : MyResponse.error(false);
  }
// TODO: REFRESH TOKEN FLOW REQUEST TESTING END -------------------------
}

/// For unit testing purposes
class MockUserRepository extends Mock implements UserRepository {}