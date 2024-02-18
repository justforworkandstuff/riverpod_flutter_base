import 'package:dumbdumb_flutter_app/app/assets/app_router.dart';
import 'package:dumbdumb_flutter_app/app/assets/importers/importer_structural.dart';

/// Environment supported in this project
enum EnvironmentType { production, staging, development }

/// Common RESTful HTTP request types
enum HttpRequestType { get, post, put, delete }

enum HomePages {
  counter,
  todo,
  network;

  String get displayName {
    switch (this) {
      case HomePages.counter:
        return S.current.counter;
      case HomePages.todo:
        return S.current.todo;
      case HomePages.network:
        return S.current.network;
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
    }
  }
}
