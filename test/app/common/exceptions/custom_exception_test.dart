import 'package:dumbdumb_flutter_app/app/common/exceptions/custom_exception.dart';
import 'package:dumbdumb_flutter_app/app/common/model/error_model.dart';
import 'package:test/test.dart';

void main() async {
  _customExceptionGroupTests();
}

void _customExceptionGroupTests() {
  group('CustomException class group tests', () {
    test(
        'GIVEN an object of [CustomException] class '
        'WHEN compared against the initialization of another object of same value with identical() method '
        'THEN a [bool] value of true should be returned', () {
      // Given
      const value = ErrorModel(errorCode: 999, errorMessage: 'Tests');
      const customExceptionObject = CustomException(value);
      const customExceptionObject2 = CustomException(value);
      // When
      const result = identical(customExceptionObject, customExceptionObject2);
      // Then
      expect(result, true);
    });

    test(
        'GIVEN an object of [CustomException] class '
        'WHEN compared against the initialization of another object of different value with identical() method '
        'THEN a [bool] value of false should be returned', () {
      // Given
      const value = ErrorModel(errorCode: 999, errorMessage: 'Tests');
      const value2 = ErrorModel(errorCode: 999, errorMessage: 'Test');
      const customExceptionObject = CustomException(value);
      const customExceptionObject2 = CustomException(value2);
      // When
      const result = identical(customExceptionObject, customExceptionObject2);
      // Then
      expect(result, false);
    });
  }, tags: ['mobile', 'unit']);
}
