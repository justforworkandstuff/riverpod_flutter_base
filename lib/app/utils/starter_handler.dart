import 'package:dumbdumb_flutter_app/app/core/importers/importer_model.dart';
import 'package:dumbdumb_flutter_app/app/utils/shared_preference_handler.dart';
import 'package:flutter/cupertino.dart';

/// Function to perform all initial configuration based on running environment
/// Any method, feature that requires to init()/start() before app running, may do it here
Future<void> init(EnvironmentType type) async {
  WidgetsFlutterBinding.ensureInitialized();

  //Setting up sharedPreference instance
  await SharedPreferenceHandler.getSharedPreference();

  // // Initialize Firebase Configurations
  // await NotificationHandler.getInstance(type);
  //
  // // Pass all uncaught errors from the framework to Crashlytics.
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
}
