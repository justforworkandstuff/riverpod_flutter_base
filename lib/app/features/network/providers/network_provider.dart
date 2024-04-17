import 'package:dumbdumb_flutter_app/app/features/network/repo/auth_repository.dart';
import 'package:dumbdumb_flutter_app/app/features/network/repo/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_provider.g.dart';

@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepository(ref: ref);
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository();
}
