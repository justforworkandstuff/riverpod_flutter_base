# Riverpod Flutter Base Template

[![License: MIT][license_badge]][license_link]

This is a base project that is developed with [Riverpod] being the heart of the project in mind.

## Basic features incorporated in this project includes:

- Flavouring
- Firebase Integration
- Notification handler
- Sample API calls
- Localizations
- Shared Preference as local storage
- Go Router
- Base pages and util method to quickly start off the development

---

## Table of contents

- [Getting Started](#getting-started-)
- [Folder Structure](#folder-structure)
- [Project Architecture](#project-architecture)
    - [View](#view)
    - [Controller](#controller)
    - [Services](#services)
    - [Repository (Data source)](#repository-data-source)
- [State management](#state-management)
    - [Provider](#using-the-provider)
    - [Notifier](#using-the-notifier)
- [App routing with Go Router](#app-routing-with-go-router)
    - [Declaring Routes](#declaring-routes)
    - [Navigation and Redirection](#navigation-and-redirection)
- [Firebase](#working-with-firebase)
    - [Firebase configuration](#firebase-configuration)
    - [Firebase Cloud Messaging](#firebase-cloud-messaging)
- [Working with translations](#working-with-translations-)
    - [Adding strings](#adding-strings)
    - [Adding supported locales](#adding-supported-locales)
    - [Adding translations](#adding-translations)
- [Credits](#credits)

## Getting Started 🚀

1. This project contains 3 flavors:

- development
- staging
- production

2. To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the
   following commands in terminal:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

3. To make configurations/options based on flavors, add/update configs in `app_options.dart` class
   at `lib/app/core/` directory

```dart
class DevelopmentConstant {
  static const String apiEndpoint = 'Your api url';
}

class StagingConstant {
  static const String apiEndpoint = 'Your api url';
}

class ProductionConstant {
  static const String apiEndpoint = 'Your api url';
}
```

## Folder structure

The directory of the project should strictly follow these patterns in order to keep the project
clean and simple:

```
   |-- lib
   |   |-- app
   |   |   |-- features
   |   |   |   |-- newFeature
   |   |   |   |   |-- widgets
   |   |   |   |   |-- model
   |   |   |   |   |-- notifiers
   |   |   |   |   |-- providers
   |   |   |   |   |-- repo
   |   |   |   |   |-- service
   |   |   |   |   |   |-- view.dart
   |   |-- generated
   |   |-- l10n
```

## Project Architecture

The architecture of the project adapts the following flow:

`View > Controllers (Notifiers) > Service > Repo > Data source (with Dio)`

The reason why this architecture is adapted it due to [Riverpod] being the core of the project.

#### View

- Should be as dumb as possible to have separation of concern
- Should avoid usage of `setState` as much as possible and use [Riverpod] for the UI state
  management
- Should have at least one or more controllers for each view to handle each state of the UI
  components
- Should extend `base_consumer_stateful_widget.dart` or `base_consumer_widget.dart` page for basic
  unified features and widgets

#### Controller

- Should be used with Riverpod's Notifier Provider
- Should be used to handle the state changes of the presentation layer
- Should be reused where possible

#### Services

- Should be used to separate the business logic and data source from each other
- Should be used to de-clutter the business logic from controller
- Should perform an action (e.g. get data from local/network, combine data from different sources
  before passing it back to controller)

#### Repository (Data source)

- Should be use as an intermediary between the business logic and data source
- Should be used to communicate with the data sources (e.g. remote or local sources)
- Should be used as a data storage

## State Management

This project relies on [Riverpod] as the state management tool, along with the usage of
code-generation through [build_runner].

To start off, please have a look at [Riverpod's Quickstart guide].

Core concepts in [Riverpod]:

1. [Provider]
2. [Notifier]

### Using the Provider

1. The usage of provider is to represent a value (that may be changed in the future) to be used in
   multiple places.
2. Example of the usage of provider may be seen
   through `lib/app/core/configurations/app_options_providers.dart`.
3. For any new value that are related to app options, please register in
   the `lib/app/core/configurations/app_options_providers.dart`.

```dart
@riverpod
String stringValue(StringValueRef ref) {
  return 'string value';
}
```

4. To access a provider value:

```dart
String getValue(WidgetRef ref) {
  return ref.read(stringValueProvider);
}
```

### Using the Notifier

1. The usage of notifier is to act as a controller to manage the state of the UI.
2. Examples of the usage of a notifier can be referenced from examples of the features
   in `lib/app/features/`.
3. An simple example of notifier usage are as following:
   Note: This is used along with code-generator.

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'file_name.g.dart';

@riverpod
class CounterValue extends _$CounterValue {
  @override
  int build() {
    return 0;
  }

  void increment() => state++;

  void decrement() => state--;
}
```

4. Usage of the notifier can be done so by:

```dart
@override
Widget body(BuildContext context, WidgetRef ref) {
  final counterValue = ref.watch(counterValueProvider);

  return Text(counterValue.toString());
}

@override
Widget floatingActionButton(WidgetRef ref, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      FloatingActionButton(
          onPressed: () {
            ref.read(counterControllerProvider.notifier).increment();
          },
          child: const Icon(Icons.add)),
      const SizedBox(width: 10),
      FloatingActionButton(
          onPressed: () {
            ref.read(counterControllerProvider.notifier).decrement();
          },
          child: const Icon(Icons.remove)),
    ],
  );
}
```

5. Notice that for notifiers we would need to explicitly specify `customProvider.notifer` in order
   to access to the notifier's methods.

## App Routing with Go Router

This project using router to navigating between screens and handling deep links.
[go_router] package is used due to its capability to support deeplink handling, Flutter's Navigation
2.0 (declarative API routing mechanism) as well as the package being officially endorsed and
maintained by Flutter team.

### Declaring Routes

`lib/app/core/app_router.dart` is the class used for the configurations of all routes within the
project.
For any new screens or new routes, you may add in a [GoRoute] object into the [GoRouter]
constructor.

#### GoRoute

To configure a [GoRoute], a path template and builder must be provided.
Specifiy a path template to handle by providing a path parameter, and a builder by providing either
the builder or a pageBuilder parameter:

```dart

final GoRouter router = GoRouter(routes: [
  GoRoute(path: '/login', builder: (context, state) => LoginPage())
]);
```

#### Child Routes

A matched route can result in more than one screen being displayed on a Navigator. This is
equivalent
to calling `push()', where a new screen is displayed above the previous screen with a transition
animation.

To display a screen on top of another, add a child route by adding it to the parent route's `routes'
list:

```dart

final GoRouter router = GoRouter(routes: [
  GoRoute(path: '/login', builder: (context, state) => LoginPage()),
  GoRoute(path: 'profile', builder: (context, state) => HomePage(initialIndex: 4), routes: [
    GoRoute(
        path: 'editProfile',
        builder: (context, state) => EditBasicInfoPage(),
        routes: [
          GoRoute(path: 'changePhoneNumber', builder: (context, state) => ChangePhoneNumberPage())
        ]),
    GoRoute(path: 'changeLanguage', builder: (context, state) => LanguageListPage())
  ])
]);
```

### Navigation and Redirection

#### Go directly to a destination

Navigating to a destination in [GoRouter] will replace the current stack of screens with the screens
configured to be displayed for the destination route. To change to a new screen, call `context.go()`
with a URL, as the following example:

```dart
context.go('/login');
```

#### Imperative navigation

GoRouter can push a screen onto the Navigator's history stack using `context.push()`, and can pop
the
current screen via `context.pop()`. However, imperative navigation is known to cause issues with the
browser history, thus it is advised to avoid using it as much as possible.

#### Returning values from pages with Go Router

You can wait for a value to be returned from the destination:

Initial page:

```dart 
await context.go('/login');
if (result...) ...
```

Returning page:

```dart
final result = true;
context.pop(result);
```

## Working with Firebase

This project integrated Firebase product such as Firebase Cloud Messaging, Analytics, as well as
Crashlytic for app analytic and performance monitoring. The integration of Firebase components are
following the [Add Firebase to your Flutter app].

### Firebase Configuration

1. To update configuration key and identifiers, look for the configuration class
   in `lib/app/core/configurations/firebase_options.dart` and update the
   respective configuration accordingly.

Example:

```dart

static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'Your api key',
    appId: 'Your app id',
    messagingSenderId: 'Your messaging sender id',
    projectId: 'Your project id',
    storageBucket: 'Your storage bucket id',
);

static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'Your api key',
    appId: 'Your app id',
    messagingSenderId: 'Your sender id',
    projectId: 'Your project id',
    storageBucket: 'Your storage bucket',
    iosClientId: 'Your iosClientId',
    iosBundleId: 'Your iosBundleId',
);
```

### Firebase Cloud Messaging

A basic notification handling custom class is included within the project
(`lib/app/core/handlers/notification_handler.dart`), which is tasked to handle messages received
from notifications, in each state:

1. Foreground
2. Background
3. Terminated

All of these respective states have their own logic and criteria for display, for more info, may
refer
to [Firebase Cloud Messaging official documentation][firebase_cloud_messaging_official_documentation].

In this project, we're applying the notification handling with two main
packages: [firebase_messaging] and [flutter_local_notifications].

The reason for this, is that Android have a custom behaviour that does not show notifications, if
user is in foreground state.
Therefore, we need to use [flutter_local_notifications] to show in foreground state.

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows
the [official internationalization guide for Flutter][internationalization_link].

Note: This project uses Flutter's Intl Plugin to work with localizations, when enabled plugin
should automatically detect any changes in the `intl_language.arb` files and update accordingly.
Pre-requisites: Download plugin from [Flutter_Intl_Plugin].

### Adding Strings

1. To add a new localizable string, open the `intl_en.arb` file at `lib/l10n/intl_en.arb`.

```arb
{
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

2. To add a key/value pair:

```arb
{
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    },
    "nameIs": "Name is: {value}",
    "@nameIs": {
        "placeholders": {
            "value": {
                "type": "String"
            }
        }
    }
}
```

3. Use the strings as following example

```dart
import 'package:dumbdumb_flutter_app/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  return Row(
      children: [
        Text(S.current.helloWorld),
        Text(S.current.nameIs('Testing'))
      ]
  );
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include
the new locale.

```xml
    ...

<key>CFBundleLocalizations</key>    <array>
<string>en</string>
<string>es</string>
</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/`.

```
├── l10n
│   ├── arb
│   │   ├── intl_en.arb
│   │   └── intl_es.arb
```

2. Add the translated strings to each `.arb` file:

`intl_en.arb`

```arb
{
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Text used in the first page"
    }
}
```

`intl_es.arb`

```arb
{
    "helloWorld": "Hola Mundo",
    "@helloWorld": {
        "description": "Texto utilizado en la primera página."
    }
}
```

## Credits

A grateful and honest appreciation to the [very_good_cli] team for their setup of flavouring,
localizations and many more features for a Flutter base template to quickly kick start on a Flutter
project.

Besides, here's another toast of utmost gratitude to [heickjack619lok], for starting off a base
project [dumbdumb_flutter] which this template project origins from.
In the initial project, it has already covered up a lot of the features and principles that are
ready to be used and thus allowing the speedy preparation of this template to be ready of use.

[coverage_badge]: coverage_badge.svg

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg

[license_link]: https://opensource.org/licenses/MIT

[Add Firebase to your Flutter app]: https://firebase.google.com/docs/flutter/setup?platform=ios

[Riverpod's Quickstart Guide]: https://riverpod.dev/docs/from_provider/quickstart

[build_runner]: https://pub.dev/packages/build_runner

[Riverpod]: https://pub.dev/packages/flutter_riverpod

[Provider]: https://riverpod.dev/docs/essentials/side_effects#defining-a-notifier

[Notifier]: https://riverpod.dev/docs/essentials/side_effects#defining-a-notifier

[go_router]: https://pub.dev/packages/go_router

[GoRoute]: https://pub.dev/documentation/go_router/latest/go_router/GoRoute-class.html

[GoRouter]: https://pub.dev/documentation/go_router/latest/go_router/GoRouter-class.html

[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html

[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization

[firebase_cloud_messaging_official_documentation]: https://firebase.google.com/docs/cloud-messaging/flutter/receive

[firebase_messaging]: https://pub.dev/packages/firebase_messaging

[flutter_local_notifications]: https://pub.dev/packages/flutter_local_notifications

[Flutter_Intl_Plugin]: https://plugins.jetbrains.com/plugin/13666-flutter-intl

[very_good_cli]: https://github.com/VeryGoodOpenSource/very_good_cli

[heickjack619lok]: https://github.com/heickjack619lok

[dumbdumb_flutter]: https://github.com/heickjack619lok/dumbdumb_flutter
