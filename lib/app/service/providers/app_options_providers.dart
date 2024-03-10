import 'package:dumbdumb_flutter_app/app/core/app_options.dart';
import 'package:dumbdumb_flutter_app/app/core/enums.dart';
import 'package:dumbdumb_flutter_app/app/utils/shared_preference_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Necessary for code-generation to work
part 'app_options_providers.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
EnvironmentType currentFlavour(CurrentFlavourRef ref) {
  return EnvironmentType.staging;
}

@riverpod
String refreshTokenUrl(RefreshTokenUrlRef ref) {
  final currentFlavour = ref.read(currentFlavourProvider);
  switch (currentFlavour) {
    case EnvironmentType.development:
      return DevelopmentConstant.refreshTokenUrl;
    case EnvironmentType.staging:
      return StagingConstant.refreshTokenUrl;
    case EnvironmentType.production:
      return ProductionConstant.refreshTokenUrl;
    default:
      return '';
  }
}

@Riverpod(keepAlive: true, dependencies: [])
String authToken(AuthTokenRef ref) {
  return SharedPreferenceHandler.getAccessToken();
}

@Riverpod(keepAlive: true, dependencies: [])
String refreshToken(RefreshTokenRef ref) {
  return SharedPreferenceHandler.getAccessToken();
}
