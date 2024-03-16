import 'package:dumbdumb_flutter_app/app/core/importers/importer_general.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_model.dart';
import 'package:dumbdumb_flutter_app/app/core/dio/dio_controller.dart';
import 'package:dumbdumb_flutter_app/app/core/handlers/shared_preference_handler.dart';

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
          'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjA5YWZhMzM3LWU2MWUtNDE0OS05YjFlLTQ0NjkzM2Q0OTU2NCIsInJvbGVzIjpbInVzZXIiLCJhZG1pbiJdLCJjbGFpbXMiOlsicGxhbl90cmlwIiwidmlld19zdGF0aW9uIiwicGxhbl90cmlwIiwidmlld19zdGF0aW9uIl0sInJvbCI6ImFwaV90b2tlbiIsImp0aSI6Ijc5M2YwZjdjLWRiMTUtNDI5NS1iOGEzLTFjNTYwMTRmMzk4ZSIsImlhdCI6MTcxMDU4NTY2NywiZXhwIjoxNzEwNTg5MjY3LCJhdWQiOiJhZ21vZXYud2ViLmFnbW9zdHVkaW8iLCJpc3MiOiJhZ21vZXYuc3RnLnNlcnZlci5hZ21vc3R1ZGlvIn0.YEV5F0nsTCwf22h2cdswmRjDdmIpS-nrD-FyGD9kwEbTjhw6oLE_Fm0WxKCPn-nxcPuT2X74Gz1S0_4Uz2EIktCnpa9WxuiTf2RARj0IZTq5l0niWACYd6r6L5TG89dh8-D-dZ9muMDLQfq40wcIgp3PU2G1vjQnpHRhL8nmNWEXCDrvJ7TDhulQIOWYhGY5GKOxzWv-mrzdUVrJ5wCd_5U6jwCo5ivoktexU3tBk2e1dau9ioqIZIDnwybX_CHTvgJXRXcZDC8XEvEDnEmVDBpQOWOxUNIkYByMOMO_XUvK_56s5HwNhtazfiRpCPVB8KOxrRtTldcYAaUo4VbSCA/12312'),
      SharedPreferenceHandler.putRefreshToken(
          'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjA5YWZhMzM3LWU2MWUtNDE0OS05YjFlLTQ0NjkzM2Q0OTU2NCIsImRldmljZU5vIjoiOWQ0YWU2ODk1ODQwMGZmNSIsInJvbCI6InJlZnJlc2hfdG9rZW4iLCJqdGkiOiI1YzA0NTY5NS03NGVlLTQzZTgtOTk1YS1mMzFhNTc3OGUyMGYiLCJpYXQiOjE3MTA1ODU2NjcsImF1ZCI6ImFnbW9ldi53ZWIuYWdtb3N0dWRpbyIsImlzcyI6ImFnbW9ldi5zdGcuc2VydmVyLmFnbW9zdHVkaW8ifQ.p46_mh9l_D7J9YBzdi9eD6P7MnZDjsXRwG4YMAeEojbontAxqYko5H1ktlko_ZcxiDO63DZlz-71aLlqs9flpmlFkZuMkZDLbrXeGMy-XAecxrExJtBngLJyfpPD79ZG2NCw0WyEAmmqVqFHB9R2wWcvpwJ9aIf8um_Y1XUe6jvbsP7Pc93uWaBt532AW6Gy4Mp7qbBbqXlXnuupatvAG2xW5GS0Hwy2BEJh0DdczhMlwXLz-FudfRBvau4bHgiO37d9MQtcr78GW7cv8MeER917-09N-DXo4z1gSbeJH7p1x2PhmtuUasWEznljvOeUVQQNT8IkDtrm8h4WVUx_lw')
    ]);
    return !result.contains(false) ? MyResponse.complete(true) : MyResponse.error(false);
  }
  // TODO: REFRESH TOKEN FLOW REQUEST TESTING END -------------------------
}
