import 'package:dumbdumb_flutter_app/app/features/counter/counter_page.dart';
import 'package:dumbdumb_flutter_app/app/features/initial/initial_page.dart';
import 'package:dumbdumb_flutter_app/app/features/network/network_consumer_page.dart';
import 'package:dumbdumb_flutter_app/app/features/network/network_consumer_stateful_page.dart';
import 'package:dumbdumb_flutter_app/app/features/todo/to_do_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class RouterPath {
  static const String initialPage = '/';
  static const String counterPage = 'counter';
  static const String todoPage = 'todoPage';
  static const String networkPage = 'networkPage';
  static const String networkPageWithRefreshToken = 'networkPageWithRefreshToken';
}

class RouterPathNamed {
  static const String initialPage = 'initialPage';
  static const String counterPage = 'counterPage';
  static const String todoPage = 'todoPage';
  static const String networkPage = 'networkPage';
  static const String networkPageWithRefreshToken = 'networkPageWithRefreshToken';
}

final GoRouter router = GoRouter(initialLocation: RouterPath.initialPage, navigatorKey: AppRouter.navigatorKey, routes: [
  GoRoute(
      name: RouterPathNamed.initialPage,
      path: RouterPath.initialPage,
      builder: (context, state) => const InitialPage(),
      routes: [
        GoRoute(
            name: RouterPathNamed.counterPage,
            path: RouterPath.counterPage,
            builder: (context, state) => const CounterPage()),
        GoRoute(
            name: RouterPathNamed.todoPage, path: RouterPath.todoPage, builder: (context, state) => const ToDoPage()),
        GoRoute(
            name: RouterPathNamed.networkPage,
            path: RouterPath.networkPage,
            builder: (context, state) => const NetworkConsumerPage()),
        GoRoute(
            name: RouterPathNamed.networkPageWithRefreshToken,
            path: RouterPath.networkPageWithRefreshToken,
            builder: (context, state) => const NetworkConsumerStatefulWidget())
      ]),
]);
