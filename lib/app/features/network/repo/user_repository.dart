import 'package:dumbdumb_flutter_app/app/core/importers/importer_general.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_model.dart';
import 'package:dumbdumb_flutter_app/app/service/notifiers/dio_controller.dart';
import 'package:dumbdumb_flutter_app/app/utils/shared_preference_handler.dart';

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
    const path = 'https://evsuperapp-staging.agmostudio.com/api/v1/user';
    return await ref.read(dioControllerProvider.notifier).callAPI(HttpRequestType.get, path);
  }

  Future<MyResponse> getSecondApi() async {
    // TODO: Insert API #1 path used for testing
    const path = 'https://evsuperapp-staging.agmostudio.com/api/v1/wallet';
    return await ref.read(dioControllerProvider.notifier).callAPI(HttpRequestType.get, path);
  }

  // Put token to override simulate already login status
  Future<MyResponse> putToken() async {
    final result = await Future.wait([
      SharedPreferenceHandler.putAccessToken(
          'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjA5YWZhMzM3LWU2MWUtNDE0OS05YjFlLTQ0NjkzM2Q0OTU2NCIsInJvbGVzIjpbInVzZXIiLCJhZG1pbiJdLCJjbGFpbXMiOlsicGxhbl90cmlwIiwidmlld19zdGF0aW9uIiwicGxhbl90cmlwIiwidmlld19zdGF0aW9uIl0sInJvbCI6ImFwaV90b2tlbiIsImp0aSI6Ijc3ZTkwNzE0LTMxYjktNDYxYS1hMjg5LThlMTZhZmUyMzIyMyIsImlhdCI6MTcxMDU4NDE5NSwiZXhwIjoxNzEwNTg3Nzk1LCJhdWQiOiJhZ21vZXYud2ViLmFnbW9zdHVkaW8iLCJpc3MiOiJhZ21vZXYuc3RnLnNlcnZlci5hZ21vc3R1ZGlvIn0.KyPqfFaZLdEzZ9PyfxuXj9S12G1FQqXll1UxbaiTvqvhKyLQcka7qQGom52RvJjVP5aUmYksoNaQrlSvKRncnKv98jm5HFLUXTCfKuPndo-C_Anz_gXyLTgz1VSG4dvlro9r9M4aPuZzd3TDkPZUSYeOggTy0M0hCfNBlmS7So5iyFv2VDCc5VpwjIu5o3Ezuw9oPU2rX5NUgp2XBZj9dtZC3THEDIaBqbacd9EL3aKVJTU3jZPrOdvpMepOry5LTjo1ieFkUgQIM7ETroHMHqFOYB1nPl3PPrQNy2cXkC13EG8bu5SgOd8gRfvEaXn0gH4t1zR-ONlC5ksS7Zidew/12312'),
      SharedPreferenceHandler.putRefreshToken(
          'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjA5YWZhMzM3LWU2MWUtNDE0OS05YjFlLTQ0NjkzM2Q0OTU2NCIsImRldmljZU5vIjoiOWQ0YWU2ODk1ODQwMGZmNSIsInJvbCI6InJlZnJlc2hfdG9rZW4iLCJqdGkiOiJmMmZiNjZmMy0zZjA1LTQ5NjctYTE0YS03YTg4NWJlN2UxZmMiLCJpYXQiOjE3MTA1ODQxOTUsImF1ZCI6ImFnbW9ldi53ZWIuYWdtb3N0dWRpbyIsImlzcyI6ImFnbW9ldi5zdGcuc2VydmVyLmFnbW9zdHVkaW8ifQ.JT9_YQX_OzYMymU6ZPGy-DPzkuMaVrSQZmzcLqxQb2rDXar-gD4pxsYslSRj9Mq1c-8Nf1w9fXBoRFEPni4yWuudxZU6B0Kn8HotCTOrBAypttOq3SUE8UpDPPfkT7S3jUL8KN3AeW5WkRnpyk5jZ3PGyWgPs8xtYTnnLTOX2VkwktuWpUyImcxdNKgN2s54k3HjHyw5UNkTMaApL4wwQxMk5GY4Hy8iIOL-Y_sdl_mzHS-KQKYnvwBee5WTFrR-aszC0B3AWZO2Owdo_XCUJ_ZIfGChrcalp5viYZNAppsqwnXN0EEyYpDzHTLweeXWMoVE6pewwy1KZL2IQQ5qow')
    ]);
    return !result.contains(false) ? MyResponse.complete(true) : MyResponse.error(false);
  }
  // TODO: REFRESH TOKEN FLOW REQUEST TESTING END -------------------------
}
