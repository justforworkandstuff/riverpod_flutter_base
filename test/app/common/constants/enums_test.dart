import 'dart:ui';

import 'package:dumbdumb_flutter_app/app/common/constants/enums.dart';
import 'package:dumbdumb_flutter_app/app/core/app_router.dart';
import 'package:dumbdumb_flutter_app/generated/l10n.dart';
import 'package:test/test.dart';

void main() async {
  /// Needed to use for localized String result comparison
  final strings = await S.load(const Locale.fromSubtags(languageCode: 'en'));
  _homePagesGroupTests(strings);
  _notificationActionTypeGroupTests();
}

void _homePagesGroupTests(S strings) {
  group('displayName group tests', () {
    test(
        'GIVEN a enum [HomePages], counter '
        'WHEN displayName is called '
        'THEN the corresponding displayName of enum should be returned', () {
      // Given
      const value = HomePages.counter;
      // When
      final result = value.displayName;
      // Then
      expect(result, strings.counter);
    });

    test(
        'GIVEN a enum [HomePages], todo '
        'WHEN displayName is called '
        'THEN the corresponding displayName of enum should be returned', () {
      // Given
      const value = HomePages.todo;
      // When
      final result = value.displayName;
      // Then
      expect(result, strings.todo);
    });

    test(
        'GIVEN a enum [HomePages], network '
        'WHEN displayName is called '
        'THEN the corresponding displayName of enum should be returned', () {
      // Given
      const value = HomePages.network;
      // When
      final result = value.displayName;
      // Then
      expect(result, strings.network);
    });

    test(
        'GIVEN a enum [HomePages], networkWithRefreshToken '
        'WHEN displayName is called '
        'THEN the corresponding displayName of enum should be returned', () {
      // Given
      const value = HomePages.networkWithRefreshToken;
      // When
      final result = value.displayName;
      // Then
      expect(result, strings.networkWithRefreshToken);
    });
  }, tags: ['mobile', 'unit']);

  group('navigationPath group tests', () {
    test(
        'GIVEN a enum [HomePages], counter '
        'WHEN navigationPath is called '
        'THEN the corresponding navigationPath of enum should be returned', () {
      // Given
      const value = HomePages.counter;
      // When
      final result = value.navigationPath;
      // Then
      expect(result, RouterPathNamed.counterPage);
    });

    test(
        'GIVEN a enum [HomePages], todo '
        'WHEN navigationPath is called '
        'THEN the corresponding navigationPath of enum should be returned', () {
      // Given
      const value = HomePages.todo;
      // When
      final result = value.navigationPath;
      // Then
      expect(result, RouterPathNamed.todoPage);
    });

    test(
        'GIVEN a enum [HomePages], network '
        'WHEN navigationPath is called '
        'THEN the corresponding navigationPath of enum should be returned', () {
      // Given
      const value = HomePages.network;
      // When
      final result = value.navigationPath;
      // Then
      expect(result, RouterPathNamed.networkPage);
    });

    test(
        'GIVEN a enum [HomePages], networkWithRefreshToken '
        'WHEN navigationPath is called '
        'THEN the corresponding navigationPath of enum should be returned', () {
      // Given
      const value = HomePages.networkWithRefreshToken;
      // When
      final result = value.navigationPath;
      // Then
      expect(result, RouterPathNamed.networkPageWithRefreshToken);
    });
  }, tags: ['mobile', 'unit']);
}

void _notificationActionTypeGroupTests() {
  group('actionValue group tests', () {
    test(
        'GIVEN a enum [NotificationActionType], notificationAction '
        'WHEN actionValue is called '
        'THEN the corresponding actionValue of enum should be returned', () {
      // Given
      const value = NotificationActionType.notificationAction;
      // When
      final result = value.actionValue;
      // Then
      expect(result, 'notificationAction');
    });
  }, tags: ['mobile', 'unit']);
}
