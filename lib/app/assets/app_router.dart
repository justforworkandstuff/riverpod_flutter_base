import 'package:dumbdumb_flutter_app/app/assets/importers/importer_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/importers/importer_screens.dart';

class RouterPath {
  static const String initialPage = '/';
  static const String counterPage = 'counter';
  static const String todoPage = 'todoPage';
  static const String networkPage = 'networkPage';
}

class RouterPathNamed {
  static const String initialPage = 'initialPage';
  static const String counterPage = 'counterPage';
  static const String todoPage = 'todoPage';
  static const String networkPage = 'networkPage';
}

/// Navigator Keys needed for the use-case of bottomNavigationBar navigation to-and-return
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: RouterPath.initialPage,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      name: RouterPathNamed.initialPage,
      path: RouterPath.initialPage,
      builder: (context, state) => const InitialPage(),
      routes: [
        GoRoute(
            name: RouterPathNamed.counterPage,
            path: RouterPath.counterPage,
            builder: (context, state) => const CounterPage()
        ),
        GoRoute(
            name: RouterPathNamed.todoPage,
            path: RouterPath.todoPage,
            builder: (context, state) => const ToDoPage()
        ),
        GoRoute(
            name: RouterPathNamed.networkPage,
            path: RouterPath.networkPage,
            builder: (context, state) => const NetworkPage()
        ),
      ]
    ),
  ]
);