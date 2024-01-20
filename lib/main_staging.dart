// Copyright (c) 2022, DumbDumb
// https://dumbdumb.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:dumbdumb_flutter_app/app/assets/app_options.dart';
import 'package:dumbdumb_flutter_app/app/utils/starter_handler.dart';
import 'package:dumbdumb_flutter_app/app/view/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  // An init() Function to perform all required initial configuration before app start running
  await init(EnvironmentType.STAGING);

  // Start to run the app
  runApp(
      // For widgets to be able to read providers, we need to wrap the entire
      // application in a "ProviderScope" widget.
      // This is where the state of our providers will be stored.
      ProviderScope(child: App()));
}