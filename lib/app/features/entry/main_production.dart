// Copyright (c) 2022, DumbDumb
// https://dumbdumb.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:dumbdumb_flutter_app/app/common/constants/enums.dart';
import 'package:dumbdumb_flutter_app/app/core/configurations/app_options_providers.dart';
import 'package:dumbdumb_flutter_app/app/core/handlers/starter_handler.dart';
import 'package:dumbdumb_flutter_app/app/features/entry/app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notification from background will display on system tray by default.
/// Use this method if we need to explicitly do something after receiving notification, e.g. set up Flutter App Badge count
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('fcm: - onBackgroundMessageHandling: ${message.toMap()}');
}

Future<void> main() async {
  // An init() Function to perform all required initial configuration before app start running
  await init(EnvironmentType.production);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Start to run the app
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
      ProviderScope(
          overrides: [currentFlavourProvider.overrideWith((ref) => EnvironmentType.production)],
          child: const App()));
}