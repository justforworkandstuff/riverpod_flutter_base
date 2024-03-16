import 'package:dumbdumb_flutter_app/app/core/app_options.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_model.dart';
import 'package:dumbdumb_flutter_app/app/utils/notification_handler.dart';
import 'package:dumbdumb_flutter_app/app/utils/shared_preference_handler.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:dumbdumb_flutter_app/app/service/base_services.dart';

/// Function to perform all initial configuration based on running environment
/// Any method, feature that requires to init()/start() before app running, may do it here
Future<void> init(EnvironmentType type) async {
  WidgetsFlutterBinding.ensureInitialized();

  //Setting up sharedPreference instance
  await SharedPreferenceHandler.getSharedPreference();
  //
  // // Setup hostURL for API call in services
  // switch (type) {
  //   case EnvironmentType.production:
  //     {
  //       BaseServices.hostUrl = ProductionConstant.apiEndpoint;
  //     }
  //     break;
  //   case EnvironmentType.staging:
  //     {
  //       BaseServices.hostUrl = StagingConstant.apiEndpoint;
  //     }
  //     break;
  //   case EnvironmentType.development:
  //     {
  //       BaseServices.hostUrl = DevelopmentConstant.apiEndpoint;
  //     }
  //     break;
  // }
  //
  // // Initialize Firebase Configurations
  // await NotificationHandler.getInstance(type);
  //
  // // Pass all uncaught errors from the framework to Crashlytics.
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
}
