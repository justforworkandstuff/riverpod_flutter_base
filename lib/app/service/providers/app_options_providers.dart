import 'dart:async';

import 'package:dumbdumb_flutter_app/app/core/app_options.dart';
import 'package:dumbdumb_flutter_app/app/core/enums.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Necessary for code-generation to work
part 'app_options_providers.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
EnvironmentType currentFlavour(CurrentFlavourRef ref) {
  return EnvironmentType.staging;
}

@riverpod
String hostUrl(HostUrlRef ref) {
  final currentFlavour = ref.read(currentFlavourProvider);
  switch (currentFlavour) {
    case EnvironmentType.development:
      return DevelopmentConstant.apiEndpoint;
    case EnvironmentType.staging:
      return StagingConstant.apiEndpoint;
    case EnvironmentType.production:
      return ProductionConstant.apiEndpoint;
    default:
      return '';
  }
}

@riverpod
String refreshTokenUrl(RefreshTokenUrlRef ref) {
  final hostUrl = ref.read(hostUrlProvider);
  const refreshTokenUrl = 'api/v1/auth/refreshToken';
  return '$hostUrl/$refreshTokenUrl';
}
