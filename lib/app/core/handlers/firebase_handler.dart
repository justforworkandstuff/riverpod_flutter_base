import 'package:dumbdumb_flutter_app/app/common/constants/enums.dart';
import 'package:dumbdumb_flutter_app/app/core/configurations/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info_plus/package_info_plus.dart';

class FirebaseHandler {
  static final instance = FirebaseHandler._privateConstructor();

  FirebaseHandler._privateConstructor();

  int _currentVersionCode = 0;
  int _versionCodeForceUpdate = 0;
  int _versionCodeOptionalUpdate = 0;

  String? messageNewForceVersion;
  String? messageNewOptionalVersion;

  bool appNeedsUpdate = false;
  bool appCanBeUpdated = false;
}

extension PublicAPIs on FirebaseHandler {
  Future<void> initialize(EnvironmentType type) async {
    try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform(type));
      await setupAnalyticsAndCrashlytics();
      await setupRemoteConfig(FirebaseRemoteConfig.instance);
    } catch (e) {
      debugPrint('fcm: initialize error! ${e.toString()}');
    }
  }

  Future<void> setupAnalyticsAndCrashlytics() async {
    /// Try-catch handling for cases of network suddenly cut off during
    try {
      /// Pass all uncaught errors from the framework to Crashlytics.
      if (kReleaseMode) {
        FlutterError.onError = (errorDetails) {
          FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        };
        // TODO: To decide to record these errors to firebase or not, as it will be reporting non-crash issues as well
        /// Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(error, stack, printDetails: true);
          return true;
        };
      }
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);
      await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(kReleaseMode);
    } catch (e) {
      debugPrint('setupAnalyticsAndCrashlytics: caught exception ${e.toString()}');
    }
  }

  Future<void> setupRemoteConfig(FirebaseRemoteConfig remoteConfigInstance) async {
    final info = await PackageInfo.fromPlatform();
    _currentVersionCode = int.parse(info.buildNumber);
    await remoteConfigInstance.setDefaults({
      'version_code_force_update': _versionCodeForceUpdate,
      'version_code_optional_update': _versionCodeOptionalUpdate,
      'message_new_force_version': messageNewForceVersion ?? '',
      'message_new_optional_version': messageNewOptionalVersion ?? '',
    });

    await remoteConfigInstance.ensureInitialized();
    var connectivityResult = await InternetConnectionChecker().connectionStatus;
    if (connectivityResult == InternetConnectionStatus.connected) {
      try {
        final result = await remoteConfigInstance.fetchAndActivate();
        debugPrint('remoteConfig: fetchAndActivate result - $result');
      } catch (e) {
        debugPrint('remoteConfig: remote config error');
      }
    }

    _versionCodeForceUpdate = remoteConfigInstance.getInt('version_code_force_update');
    _versionCodeOptionalUpdate = remoteConfigInstance.getInt('version_code_optional_update');

    appNeedsUpdate = _currentVersionCode < _versionCodeForceUpdate;
    appCanBeUpdated = _currentVersionCode < _versionCodeOptionalUpdate;

    if (appNeedsUpdate) {
      messageNewForceVersion = remoteConfigInstance.getString('message_new_force_version');
    }

    if (appCanBeUpdated) {
      messageNewOptionalVersion = remoteConfigInstance.getString('message_new_optional_version');
    }
  }
}
