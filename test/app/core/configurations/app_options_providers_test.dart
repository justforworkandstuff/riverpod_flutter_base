import 'package:dumbdumb_flutter_app/app/common/constants/enums.dart';
import 'package:dumbdumb_flutter_app/app/core/configurations/app_options.dart';
import 'package:dumbdumb_flutter_app/app/core/configurations/app_options_providers.dart';
import 'package:test/test.dart';

import '../../riverpod_utility_provider_container_test.dart';

void main() {
  _currentFlavourGroupTests();
  _hostUrlGroupTests();
  _refreshTokenUrlGroupTests();
}

void _currentFlavourGroupTests() {
  group('CurrentFlavourProvider group tests', () {
    test(
        'GIVEN a container of [ProviderContainer] type '
        'WHEN container reads [currentFlavourProvider] '
        'THEN a value of [EnvironmentType.staging] should be returned in [EnvironmentType] type.', () {
      // Given
      final container = createContainer();
      // When
      final result = container.read(currentFlavourProvider);
      // Then
      expect(result, EnvironmentType.staging);
    });

    test(
        'GIVEN a container of [ProviderContainer] type override with [EnvironmentType.development] environment '
        'WHEN container reads [currentFlavourProvider] '
        'THEN a value of [EnvironmentType.development] should be returned in [EnvironmentType] type.', () {
      // Given
      final container =
          createContainer(overrides: [currentFlavourProvider.overrideWith((ref) => EnvironmentType.development)]);
      // When
      final result = container.read(currentFlavourProvider);
      // Then
      expect(result, EnvironmentType.development);
    });

    test(
        'GIVEN a container of [ProviderContainer] type override with [EnvironmentType.staging] environment '
        'WHEN container reads [currentFlavourProvider] '
        'THEN a value of [EnvironmentType.staging] should be returned in [EnvironmentType] type.', () {
      // Given
      final container =
          createContainer(overrides: [currentFlavourProvider.overrideWith((ref) => EnvironmentType.staging)]);
      // When
      final result = container.read(currentFlavourProvider);
      // Then
      expect(result, EnvironmentType.staging);
    });

    test(
        'GIVEN a container of [ProviderContainer] type override with [EnvironmentType.production] environment '
        'WHEN container reads [currentFlavourProvider] '
        'THEN a value of [EnvironmentType.production] should be returned in [EnvironmentType] type.', () {
      // Given
      final container =
          createContainer(overrides: [currentFlavourProvider.overrideWith((ref) => EnvironmentType.production)]);
      // When
      final result = container.read(currentFlavourProvider);
      // Then
      expect(result, EnvironmentType.production);
    });
  }, tags: ['mobile', 'unit']);
}

void _hostUrlGroupTests() {
  group('HostUrl group tests', () {
    test(
        'GIVEN a container of [ProviderContainer] type '
        'WHEN container reads [hostUrlProvider] '
        'THEN the value of [StagingConstant.apiEndpoint] should be returned in [String] type.', () {
      // Given
      final container = createContainer();
      // When
      final result = container.read(hostUrlProvider);
      // Then
      expect(result, StagingConstant.apiEndpoint);
    });

    test(
        'GIVEN a container of [ProviderContainer] type override with [EnvironmentType.development] environment '
        'WHEN container reads [hostUrlProvider] '
        'THEN the value of [DevelopmentConstant.apiEndpoint] should be returned in [String] type.', () {
      // Given
      final container =
          createContainer(overrides: [currentFlavourProvider.overrideWith((ref) => EnvironmentType.development)]);
      // When
      final result = container.read(hostUrlProvider);
      // Then
      expect(result, DevelopmentConstant.apiEndpoint);
    });

    test(
        'GIVEN a container of [ProviderContainer] type override with [EnvironmentType.staging] environment '
        'WHEN container reads [hostUrlProvider] '
        'THEN the value of [StagingConstant.apiEndpoint] should be returned in [String] type.', () {
      // Given
      final container =
          createContainer(overrides: [currentFlavourProvider.overrideWith((ref) => EnvironmentType.staging)]);
      // When
      final result = container.read(hostUrlProvider);
      // Then
      expect(result, StagingConstant.apiEndpoint);
    });

    test(
        'GIVEN a container of [ProviderContainer] type override with [EnvironmentType.production] environment '
        'WHEN container reads [hostUrlProvider] '
        'THEN the value of [ProductionConstant.apiEndpoint] should be returned in [String] type.', () {
      // Given
      final container =
          createContainer(overrides: [currentFlavourProvider.overrideWith((ref) => EnvironmentType.production)]);
      // When
      final result = container.read(hostUrlProvider);
      // Then
      expect(result, ProductionConstant.apiEndpoint);
    });
  }, tags: ['mobile', 'unit']);
}

void _refreshTokenUrlGroupTests() {
  group('RefreshTokenUrl group tests', () {
    late String refreshTokenUrl;
    setUp(() => refreshTokenUrl = 'api/v1/auth/refreshToken');

    test(
        'GIVEN a container of [ProviderContainer] type '
        'WHEN container reads [refreshTokenUrlProvider] '
        'THEN the value of refreshToken with hostUrl from [EnvironmentType.staging] should be returned in [String] type.',
        () {
      // Given
      final container = createContainer();
      // When
      final result = container.read(refreshTokenUrlProvider);
      // Then
      expect(result, '${StagingConstant.apiEndpoint}/$refreshTokenUrl');
    });

    test(
        'GIVEN a container of [ProviderContainer] type override with [EnvironmentType.development] environment '
        'WHEN container reads [refreshTokenUrlProvider] '
        'THEN the value of refreshToken with hostUrl from [EnvironmentType.development] should be returned in [String] type.',
        () {
      // Given
      final container =
          createContainer(overrides: [currentFlavourProvider.overrideWith((ref) => EnvironmentType.development)]);
      // When
      final result = container.read(refreshTokenUrlProvider);
      // Then
      expect(result, '${DevelopmentConstant.apiEndpoint}/$refreshTokenUrl');
    });

    test(
        'GIVEN a container of [ProviderContainer] type override with [EnvironmentType.staging] environment '
        'WHEN container reads [refreshTokenUrlProvider] '
        'THEN the value of refreshToken with hostUrl from [EnvironmentType.staging] should be returned in [String] type.',
        () {
      // Given
      final container =
          createContainer(overrides: [currentFlavourProvider.overrideWith((ref) => EnvironmentType.staging)]);
      // When
      final result = container.read(refreshTokenUrlProvider);
      // Then
      expect(result, '${StagingConstant.apiEndpoint}/$refreshTokenUrl');
    });

    test(
        'GIVEN a container of [ProviderContainer] type override with [EnvironmentType.production] environment '
        'WHEN container reads [refreshTokenUrlProvider] '
        'THEN the value of refreshToken with hostUrl from [EnvironmentType.production] should be returned in [String] type.',
        () {
      // Given
      final container =
          createContainer(overrides: [currentFlavourProvider.overrideWith((ref) => EnvironmentType.production)]);
      // When
      final result = container.read(refreshTokenUrlProvider);
      // Then
      expect(result, '${ProductionConstant.apiEndpoint}/$refreshTokenUrl');
    });
  }, tags: ['mobile', 'unit']);
}
