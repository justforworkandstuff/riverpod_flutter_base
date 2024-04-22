import 'dart:convert';

import 'package:dumbdumb_flutter_app/app/common/exceptions/custom_exception.dart';
import 'package:dumbdumb_flutter_app/app/common/model/error_model.dart';
import 'package:dumbdumb_flutter_app/app/common/model/my_response_model.dart';
import 'package:dumbdumb_flutter_app/app/features/network/controllers/user_controller.dart';
import 'package:dumbdumb_flutter_app/app/features/network/model/user_model.dart';
import 'package:dumbdumb_flutter_app/app/features/network/providers/network_provider.dart';
import 'package:dumbdumb_flutter_app/app/features/network/repo/user_repository.dart';
import 'package:dumbdumb_flutter_app/app/features/network/service/user_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mock_listener.dart';
import '../../../riverpod_utility_provider_container_test.dart';

void main() {
  group('UserController() group tests', () {
    late MockUserRepository userRepository;
    late MockUserService userService;
    late UserModel userModel;
    setUp(() {
      userRepository = MockUserRepository();
      userService = MockUserService();
      userModel =
          const UserModel(id: 1, name: 'Mock User', email: 'mockuser@email.com', profileImage: 'mockUser/image');
    });

    test(
        'GIVEN a providerNotifier of NotifierProvider type, [UserControllerNotifierProvider] '
        'WHEN initialization of the providerNotifier happens '
        'THEN no value should be returned.', () {
      // Given
      final container = createContainer();
      final listener = MockListener<UserModel?>();
      // When
      container.listen<UserModel?>(userControllerProvider, listener.call, fireImmediately: true);
      // Then
      verify(() => listener(null, null));
      verifyNoMoreInteractions(listener);
    });

    test(
        'GIVEN a providerNotifier of NotifierProvider type, [UserControllerNotifierProvider] '
        'WHEN the method [getUser()] of the providerNotifier happens, stubbed with valid response '
        'THEN a value of [UserModel] type should be returned.', () async {
      // Stubs
      when(() => userRepository.getUser())
          .thenAnswer((invocation) async => Future.value(MyResponse.complete(jsonEncode(userModel.toJson()))));

      Future<dynamic> userServiceGetUser() async {
        final response = await userRepository.getUser();
        if (response.status == ResponseStatus.complete &&
            response.data != null &&
            jsonDecode(response.data) is Map<String, dynamic>) {
          return UserModel.fromJson(jsonDecode(response.data));
        } else if (response.status == ResponseStatus.error && response.error != null) {
          throw CustomException(ErrorModel.fromJson(jsonDecode(response.error)));
        }
        throw CustomException(ErrorModel.unhandledError);
      }

      when(() => userService.getUser(userRepository)).thenAnswer((invocation) async => userServiceGetUser());
      // Given
      final container = createContainer(overrides: [
        userServiceProvider.overrideWith((ref) => userService),
        userRepositoryProvider.overrideWith((ref) => userRepository)
      ]);
      final listener = MockListener<UserModel?>();

      // Initialization
      container.listen<UserModel?>(userControllerProvider, listener.call, fireImmediately: true);

      // Method call
      final notifier = container.read(userControllerProvider.notifier);
      await notifier.getUser();
      verifyInOrder([() => listener(null, null), () => listener(null, userModel)]);
      verifyNoMoreInteractions(listener);
    });

    test(
        'GIVEN a providerNotifier of NotifierProvider type, [UserControllerNotifierProvider] '
        'WHEN the method [getUser()] of the providerNotifier happens, stubbed with error response '
        'THEN a value of [CustomException] type should be thrown.', () async {
      // Stubs
      when(() => userRepository.getUser())
          .thenAnswer((invocation) async => Future.value(MyResponse.error('{"error": "some error"}')));

      Future<dynamic> userServiceGetUser() async {
        final response = await userRepository.getUser();
        if (response.status == ResponseStatus.complete &&
            response.data != null &&
            jsonDecode(response.data) is Map<String, dynamic>) {
          return UserModel.fromJson(jsonDecode(response.data));
        } else if (response.status == ResponseStatus.error &&
            response.error != null &&
            response.error is String &&
            jsonDecode(response.error) is Map<String, dynamic>) {
          throw CustomException(ErrorModel.fromJson(jsonDecode(response.error)));
        }
        throw CustomException(ErrorModel.unhandledError);
      }

      when(() => userService.getUser(userRepository)).thenAnswer((invocation) async => userServiceGetUser());
      // Given
      final container = createContainer(overrides: [
        userServiceProvider.overrideWith((ref) => userService),
        userRepositoryProvider.overrideWith((ref) => userRepository)
      ]);
      final listener = MockListener<UserModel?>();

      // Initialization
      container.listen<UserModel?>(userControllerProvider, listener.call, fireImmediately: true);
      verify(() => listener(null, null));

      // Method call
      final notifier = container.read(userControllerProvider.notifier);
      expectLater(() async => await notifier.getUser(),
          throwsA(isA<CustomException>().having((p0) => p0.error.error, 'some error', equals('some error'))));
      verifyNoMoreInteractions(listener);
    });
  }, tags: ['mobile', 'unit']);
}
