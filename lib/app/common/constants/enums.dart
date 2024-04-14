import 'package:dumbdumb_flutter_app/app/core/app_router.dart';
import 'package:dumbdumb_flutter_app/generated/l10n.dart';

/// Environment supported in this project
enum EnvironmentType { production, staging, development }

/// Common RESTful HTTP request types
enum HttpRequestType { get, post, put, delete }

enum HomePages {
  counter,
  todo,
  network,
  networkWithRefreshToken,
  webView;

  String get displayName {
    switch (this) {
      case HomePages.counter:
        return S.current.counter;
      case HomePages.todo:
        return S.current.todo;
      case HomePages.network:
        return S.current.network;
      case HomePages.networkWithRefreshToken:
        return S.current.networkWithRefreshToken;
      default:
        return '';
    }
  }

  String get navigationPath {
    switch (this) {
      case HomePages.counter:
        return RouterPathNamed.counterPage;
      case HomePages.todo:
        return RouterPathNamed.todoPage;
      case HomePages.network:
        return RouterPathNamed.networkPage;
      case HomePages.networkWithRefreshToken:
        return RouterPathNamed.networkPageWithRefreshToken;
      default:
        return '';
    }
  }
}

enum NotificationActionType {
  notificationAction;

  const NotificationActionType();

  String get actionValue {
    switch (this) {
      case notificationAction:
        return 'notificationAction';
      default:
        return '';
    }
  }
}
