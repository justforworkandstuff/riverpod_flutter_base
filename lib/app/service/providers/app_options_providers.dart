import 'package:dumbdumb_flutter_app/app/assets/app_options.dart';
import 'package:dumbdumb_flutter_app/app/assets/enums.dart';
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
