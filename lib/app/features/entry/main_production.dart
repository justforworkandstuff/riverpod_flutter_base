// Copyright (c) 2022, DumbDumb
// https://dumbdumb.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:dumbdumb_flutter_app/app/core/importers/importer_general.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_model.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_screens.dart';
import 'package:dumbdumb_flutter_app/app/core/configurations/app_options_providers.dart';
import 'package:dumbdumb_flutter_app/app/core/handlers/starter_handler.dart';

Future<void> main() async {
  // An init() Function to perform all required initial configuration before app start running
  await init(EnvironmentType.production);

  // Start to run the app
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
      ProviderScope(
          overrides: [currentFlavourProvider.overrideWith((ref) => EnvironmentType.production)],
          child: const App()));
}