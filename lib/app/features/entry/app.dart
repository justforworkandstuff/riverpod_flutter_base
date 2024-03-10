// Copyright (c) 2022, DumbDumb
// https://dumbdumb.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:dumbdumb_flutter_app/app/core/app_router.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_general.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_structural.dart';

/// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      /// This affects the app's background title name
      // TODO: Should update the [title] to the name of the application
      title: 'Dumb dumb',
      /// Disables scaling of app's textSize based on device settings
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.textScaler.clamp();
        return MediaQuery(data: mediaQueryData.copyWith(textScaler: scale), child: child ?? const SizedBox.shrink());
      },
      // TODO: Should customize app's own theme colour
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
