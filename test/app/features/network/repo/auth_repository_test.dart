import 'package:dumbdumb_flutter_app/app/core/handlers/shared_preference_handler.dart';
import 'package:dumbdumb_flutter_app/app/features/network/repo/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _getUserImageGroupTests();
  _putUserImageGroupTests();
}

void _getUserImageGroupTests() {
  group('getUserImage() group tests', () {
    test(
        'GIVEN a setup of Shared Preference with user image data inserted '
        'WHEN AuthRepository()\'s [getUserImage()] is called '
        'THEN the value for the user image of [String] type should be returned.', () async {
      // Given
      SharedPreferenceHandler.disposeSharedPreference();
      final Map<String, Object> values = <String, Object>{SharedPreferenceHandler.spUserImage: 'test/dummy_image.png'};
      SharedPreferences.setMockInitialValues(values);
      await SharedPreferenceHandler.getSharedPreference();
      // When
      final result = AuthRepository().getUserImage();
      // Then
      expect(result, 'test/dummy_image.png');
    });

    test(
        'GIVEN a setup of Shared Preference with no data inserted '
        'WHEN AuthRepository()\'s [getUserImage()] is called '
        'THEN an empty value of [String] type should be returned.', () async {
      // Given
      SharedPreferenceHandler.disposeSharedPreference();
      final Map<String, Object> values = <String, Object>{};
      SharedPreferences.setMockInitialValues(values);
      await SharedPreferenceHandler.getSharedPreference();
      // When
      final result = AuthRepository().getUserImage();
      // Then
      expect(result, '');
    });
  }, tags: ['mobile', 'unit']);
}

void _putUserImageGroupTests() {
  group('putUserImage() group tests', () {
    test(
        'GIVEN a setup of Shared Preference with no data inserted '
        'WHEN AuthRepository()\'s [putUserImage()] is called '
        'THEN the status of the insert action of [bool] type should be returned.', () async {
      // Given
      SharedPreferenceHandler.disposeSharedPreference();
      final Map<String, Object> values = <String, Object>{};
      SharedPreferences.setMockInitialValues(values);
      await SharedPreferenceHandler.getSharedPreference();
      // When
      final result = await AuthRepository().putUserImage('test/put_user_image.png');
      // Then
      expect(result, true);
    });

    test(
        'GIVEN a setup of Shared Preference with no data inserted '
        'WHEN AuthRepository()\'s [putUserImage()] is called '
        'THEN the status of the inseert action of [bool] type and inserted value of [String] type should be returned.',
        () async {
      // Given
      SharedPreferenceHandler.disposeSharedPreference();
      final Map<String, Object> values = <String, Object>{};
      SharedPreferences.setMockInitialValues(values);
      await SharedPreferenceHandler.getSharedPreference();
      // When
      final resultInsert = await AuthRepository().putUserImage('test/put_user_image.png');
      final resultGet = SharedPreferenceHandler.getUserImage();
      // Then
      expect((resultInsert, resultGet), (true, 'test/put_user_image.png'));
    });
  }, tags: ['mobile', 'unit']);
}
