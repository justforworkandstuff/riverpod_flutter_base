import 'package:dumbdumb_flutter_app/app/common/model/error_model.dart';
import 'package:dumbdumb_flutter_app/app/common/model/success_model.dart';
import 'package:dumbdumb_flutter_app/app/core/util.dart';
import 'package:test/test.dart';

void main() async {
  _dynamicParsingGroupTests();
  _jsonParsingGroupTests();
  _stringExtensionGroupTests();
  _dateTimeParsingGroupTests();
}

void _dynamicParsingGroupTests() {
  group('parseString() group tests', () {
    test(
        'GIVEN a value of [int] type '
        'WHEN parseString() is called '
        'THEN the value of [String] type should be returned.', () {
      // Given
      const value = 12.3;
      // When
      final result = DynamicParsing(value).parseString();
      // Then
      expect(result, '12.3');
    });

    test(
        'GIVEN an empty string '
        'WHEN parseString() is called '
        'THEN empty string should be returned.', () {
      // Given
      String value = '';
      // When
      final result = DynamicParsing(value).parseString();
      // Then
      expect(result, '');
    });

    test(
        'GIVEN a null value '
        'WHEN parseString() is called '
        'THEN empty string should be returned.', () {
      // Given
      int? value;
      // When
      final result = DynamicParsing(value).parseString();
      // Then
      expect(result, '');
    });
  }, tags: ['mobile', 'unit']);

  group('parseInt() group tests', () {
    test(
        'GIVEN a non-numeric value of [String] type '
        'WHEN parseInt() is called '
        'THEN 0 value should be returned.', () {
      // Given
      const value = 'abc';
      // When
      final result = DynamicParsing(value).parseInt();
      // Then
      expect(result, 0);
    });

    test(
        'GIVEN a numeric value of [String] type '
        'WHEN parseInt() is called '
        'THEN the same numeric value of [int] type should be returned.', () {
      // Given
      String value = '12';
      // When
      final result = DynamicParsing(value).parseInt();
      // Then
      expect(result, 12);
    });

    test(
        'GIVEN a numeric value of [double] type '
        'WHEN parseInt() is called '
        'THEN 0 value should be returned.', () {
      // Given
      double value = 12.3;
      // When
      final result = DynamicParsing(value).parseInt();
      // Then
      expect(result, 0);
    });

    test(
        'GIVEN a null value '
        'WHEN parseInt() is called '
        'THEN 0 value should be returned.', () {
      // Given
      int? value;
      // When
      final result = DynamicParsing(value).parseInt();
      // Then
      expect(result, 0);
    });
  }, tags: ['mobile', 'unit']);

  group('parseDouble() group tests', () {
    test(
        'GIVEN a non-numeric value of [String] type '
        'WHEN parseDouble() is called '
        'THEN 0 value should be returned.', () {
      // Given
      const value = 'abc';
      // When
      final result = DynamicParsing(value).parseDouble();
      // Then
      expect(result, 0.0);
    });

    test(
        'GIVEN a numeric value of [String] type '
        'WHEN parseDouble() is called '
        'THEN the numeric value of [double] type should be returned.', () {
      // Given
      String value = '12';
      // When
      final result = DynamicParsing(value).parseDouble();
      // Then
      expect(result, 12.0);
    });

    test(
        'GIVEN a numeric value of [double] type '
        'WHEN parseDouble() is called '
        'THEN the numeric value of [double] type should be returned.', () {
      // Given
      double value = 12.3;
      // When
      final result = DynamicParsing(value).parseDouble();
      // Then
      expect(result, 12.3);
    });

    test(
        'GIVEN a null value '
        'WHEN parseDouble() is called '
        'THEN 0 value should be returned.', () {
      // Given
      double? value;
      // When
      final result = DynamicParsing(value).parseDouble();
      // Then
      expect(result, 0);
    });
  }, tags: ['mobile', 'unit']);

  group('parseBool() group tests', () {
    test(
        'GIVEN a boolean value of [String] type '
        'WHEN parseBool() is called '
        'THEN the boolean value of [bool] type should be returned.', () {
      // Given
      const value = 'true';
      // When
      final result = DynamicParsing(value).parseBool();
      // Then
      expect(result, true);
    });

    test(
        'GIVEN an empty value of [String] type '
        'WHEN parseBool() is called '
        'THEN false value should be returned.', () {
      // Given
      String value = '';
      // When
      final result = DynamicParsing(value).parseBool();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN a null value '
        'WHEN parseBool() is called '
        'THEN false value should be returned.', () {
      // Given
      bool? value;
      // When
      final result = DynamicParsing(value).parseBool();
      // Then
      expect(result, false);
    });
  }, tags: ['mobile', 'unit']);
}

void _jsonParsingGroupTests() {
  group('toJson() group tests', () {
    late ErrorModel modelWithToJson;
    late SuccessModel modelWithoutToJson;

    setUp(() {
      modelWithToJson = const ErrorModel(errorCode: 999);
      modelWithoutToJson = SuccessModel(success: true);
    });

    test(
        'GIVEN a random value of [String] type '
        'WHEN toJson() is called '
        'THEN the same value of [String] type should be returned.', () {
      // Given
      const value = 'this is a string';
      // When
      final result = value.toJson();
      // Then
      expect(result, '"this is a string"');
    });

    test(
        'GIVEN a random value of [int] type '
        'WHEN toJson() is called '
        'THEN the same value of [String] type should be returned.', () {
      // Given
      const value = 12;
      // When
      final result = JsonParsing(value).toJson();
      // Then
      expect(result, '12');
    });

    test(
        'GIVEN a random value of [double] type '
        'WHEN toJson() is called '
        'THEN the same value of [String] type should be returned.', () {
      // Given
      const value = 12.3;
      // When
      final result = JsonParsing(value).toJson();
      // Then
      expect(result, '12.3');
    });

    test(
        'GIVEN a random value of [bool] type '
        'WHEN toJson() is called '
        'THEN the same value of [String] type should be returned.', () {
      // Given
      const value = false;
      // When
      final result = JsonParsing(value).toJson();
      // Then
      expect(result, 'false');
    });

    test(
        'GIVEN a random value of [Map] type '
        'WHEN toJson() is called '
        'THEN the same value of [String] type should be returned.', () {
      // Given
      const value = {'key': 'value'};
      // When
      final result = JsonParsing(value).toJson();
      // Then
      expect(result, '{"key":"value"}');
    });

    test(
        'GIVEN a random value of [List] type '
        'WHEN toJson() is called '
        'THEN the same value of [String] type should be returned.', () {
      // Given
      const value = [1, 2, 3];
      // When
      final result = JsonParsing(value).toJson();
      // Then
      expect(result, '[1,2,3]');
    });

    test(
        'GIVEN a random value of [Object] type with toJson() method defined '
        'WHEN toJson() is called '
        'THEN the same object of [String] type should be returned.', () {
      // Given
      final value = modelWithToJson;
      // When
      final result = JsonParsing(value).toJson();
      // Then
      expect(result, '{"statusCode":999,"message":null,"errorCode":null,"error":null,"errorDescription":null}');
    });

    test(
        'GIVEN a random value of [Object] type without .toJson() method defined '
        'WHEN toJson() is called '
        'THEN an empty string should be returned.', () {
      // Given
      final value = modelWithoutToJson;
      // When
      final result = JsonParsing(value).toJson();
      // Then
      expect(result, '');
    });
  }, tags: ['mobile', 'unit']);

  group('fromJson() group tests', () {
    test(
        'GIVEN a map value of [String] type '
        'WHEN fromJson() is called '
        'THEN the same value of [Map] type should be returned.', () {
      // Given
      const value = '{"id": 1, "name": "Test"}';
      // When
      final result = JsonParsing(value).fromJson();
      // Then
      expect(result, {'id': 1, 'name': 'Test'});
    });

    test(
        'GIVEN a random value of [int] type '
        'WHEN fromJson() is called '
        'THEN an empty [Map] type should be returned.', () {
      // Given
      const value = 1;
      // When
      final result = JsonParsing(value).fromJson();
      // Then
      expect(result, {});
    });

    test(
        'GIVEN a whitespace value of [String] type '
        'WHEN allCap() is called '
        'THEN an empty value of [Map] type should be returned.', () {
      // Given
      const value = ' ';
      // When
      final result = JsonParsing(value).fromJson();
      // Then
      expect(result, {});
    });
  }, tags: ['mobile', 'unit']);
}

void _stringExtensionGroupTests() {
  group('capitalize() group tests', () {
    test(
        'GIVEN a random value of [String] type '
        'WHEN capitalize() is called '
        'THEN the same value of [String] type with the first character capitalized should be returned.', () {
      // Given
      const value = 'this is a string';
      // When
      final result = StringExtension(value).capitalize();
      // Then
      expect(result, 'This is a string');
    });

    test(
        'GIVEN a random value of [String] type with first letter capitalized '
        'WHEN capitalize() is called '
        'THEN the same value of [String] type should be returned.', () {
      // Given
      const value = 'This is a string';
      // When
      final result = StringExtension(value).capitalize();
      // Then
      expect(result, 'This is a string');
    });

    test(
        'GIVEN an empty value of [String] type '
        'WHEN capitalize() is called '
        'THEN an empty value of [String] type should be returned.', () {
      // Given
      const value = '';
      // When
      final result = StringExtension(value).capitalize();
      // Then
      expect(result, '');
    });

    test(
        'GIVEN a null value '
        'WHEN capitalize() is called '
        'THEN an empty value of [String] type should be returned.', () {
      // Given
      String? value;
      // When
      final result = (value ?? '').capitalize();
      // Then
      expect(result, '');
    });

    test(
        'GIVEN a random value of [String] type with length less than 2 '
        'WHEN capitalize() is called '
        'THEN an empty value of [String] type should be returned.', () {
      // Given
      const value = 't';
      // When
      final result = StringExtension(value).capitalize();
      // Then
      expect(result, 'T');
    });

    test(
        'GIVEN a numeric value of [String] type '
        'WHEN capitalize() is called '
        'THEN the same numeric value of [String] type should be returned.', () {
      // Given
      const value = '1';
      // When
      final result = StringExtension(value).capitalize();
      // Then
      expect(result, '1');
    });

    test(
        'GIVEN an alphabet of [String] type '
        'WHEN capitalized() is called '
        'THEN the same value of [String] type should be returned.', () {
      // Given
      const value = '#';
      // When
      final result = StringExtension(value).capitalize();
      // Then
      expect(result, '#');
    });
  }, tags: ['mobile', 'unit']);

  group('allCap() group tests', () {
    test(
        'GIVEN a random value of [String] type '
        'WHEN allCap() is called '
        'THEN the same value of [String] type with the all characters capitalized should be returned.', () {
      // Given
      const value = 'this is a string';
      // When
      final result = StringExtension(value).allCap();
      // Then
      expect(result, 'THIS IS A STRING');
    });

    test(
        'GIVEN a random value of [String] type with all characters already capitalized '
        'WHEN allCap() is called '
        'THEN the same value of [String] type with all the characters capitalized should be returned.', () {
      // Given
      const value = 'THIS IS A STRING';
      // When
      final result = StringExtension(value).allCap();
      // Then
      expect(result, 'THIS IS A STRING');
    });

    test(
        'GIVEN an empty value of [String] type '
        'WHEN allCap() is called '
        'THEN an empty value of [String] type should be returned.', () {
      // Given
      const value = '';
      // When
      final result = StringExtension(value).allCap();
      // Then
      expect(result, '');
    });

    test(
        'GIVEN a null value '
        'WHEN allCap() is called '
        'THEN an empty value of [String] type should be returned.', () {
      // Given
      String? value;
      // When
      final result = (value ?? '').allCap();
      // Then
      expect(result, '');
    });

    test(
        'GIVEN a numeric value of [String] type '
        'WHEN allCap() is called '
        'THEN the same numeric value of [String] type should be returned.', () {
      // Given
      const value = '123';
      // When
      final result = StringExtension(value).allCap();
      // Then
      expect(result, '123');
    });

    test(
        'GIVEN an alphabet of [String] type '
        'WHEN allCap() is called '
        'THEN the same value of [String] type should be returned.', () {
      // Given
      const value = '#';
      // When
      final result = StringExtension(value).allCap();
      // Then
      expect(result, '#');
    });

    test(
        'GIVEN a whitespace value of [String] type '
        'WHEN allCap() is called '
        'THEN the same value of [String] type should be returned.', () {
      // Given
      const value = ' ';
      // When
      final result = StringExtension(value).allCap();
      // Then
      expect(result, ' ');
    });
  }, tags: ['mobile', 'unit']);

  group('isValidPhoneNumber() group tests', () {
    test(
        'GIVEN a set of numeric value of [String] type with length of 7 '
        'WHEN isValidPhoneNumber() is called '
        'THEN true value of [bool] type should be returned.', () {
      // Given
      const value = '0123456';
      // When
      final result = StringExtension(value).isValidPhoneNumber();
      // Then
      expect(result, true);
    });

    test(
        'GIVEN a set of numeric value of [String] type with length of 10 '
        'WHEN isValidPhoneNumber() is called '
        'THEN true value of [bool] type should be returned.', () {
      // Given
      const value = '0123456789';
      // When
      final result = StringExtension(value).isValidPhoneNumber();
      // Then
      expect(result, true);
    });

    test(
        'GIVEN a set of numeric value of [String] type with length of 3 '
        'WHEN isValidPhoneNumber() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = '123';
      // When
      final result = StringExtension(value).isValidPhoneNumber();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN a set of numeric value of [String] type with length of 11 '
        'WHEN isValidPhoneNumber() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = '01234567891';
      // When
      final result = StringExtension(value).isValidPhoneNumber();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN a random value of [String] type '
        'WHEN isValidPhoneNumber() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = 'asd';
      // When
      final result = StringExtension(value).isValidPhoneNumber();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN a random value with numeric value of [String] type '
        'WHEN isValidPhoneNumber() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = 'asd123';
      // When
      final result = StringExtension(value).isValidPhoneNumber();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN a random double numeric value of [String] type '
        'WHEN isValidPhoneNumber() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = '12.3';
      // When
      final result = StringExtension(value).isValidPhoneNumber();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN an alphabet value of [String] type '
        'WHEN isValidPhoneNumber() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = '#';
      // When
      final result = StringExtension(value).isValidPhoneNumber();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN an empty value of [String] type '
        'WHEN isValidPhoneNumber() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = '';
      // When
      final result = StringExtension(value).isValidPhoneNumber();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN a whitespace value of [String] type '
        'WHEN isValidPhoneNumber() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = ' ';
      // When
      final result = StringExtension(value).isValidPhoneNumber();
      // Then
      expect(result, false);
    });
  }, tags: ['mobile', 'unit']);

  group('isValidPassword() group tests', () {
    test(
        'GIVEN a set of random value of [String] type '
        'WHEN isValidPassword() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = 'Abcd123!@#\$&*~)%-(_+=/?^.';
      // When
      final result = StringExtension(value).isValidPassword();
      // Then
      expect(result, true);
    });

    test(
        'GIVEN a set of random value of [String] type without a uppercase letter specified '
        'WHEN isValidPassword() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = 'abcd123!';
      // When
      final result = StringExtension(value).isValidPassword();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN a set of random value of [String] type without a lowercase letter specified '
        'WHEN isValidPassword() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = 'ABCD123!';
      // When
      final result = StringExtension(value).isValidPassword();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN a set of random value of [String] type without a digit specified '
        'WHEN isValidPassword() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = 'Abcdefg!';
      // When
      final result = StringExtension(value).isValidPassword();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN a set of random value of [String] type without a special character specified '
        'WHEN isValidPassword() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = 'Abcd123';
      // When
      final result = StringExtension(value).isValidPassword();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN a set of random value of [String] type with less than minimum length '
        'WHEN isValidPassword() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = 'Ab1!';
      // When
      final result = StringExtension(value).isValidPassword();
      // Then
      expect(result, false);
    });
  }, tags: ['mobile', 'unit']);

  group('isValidEmail() group tests', () {
    test(
        'GIVEN a random email value of [String] type '
        'WHEN isValidEmail() is called '
        'THEN true value of [bool] type should be returned.', () {
      // Given
      const value = 'test123!#\$%&\'*+-/=?^_`{|}~@email.com';
      // When
      final result = StringExtension(value).isValidEmail();
      // Then
      expect(result, true);
    });

    test(
        'GIVEN a random email value of [String] type with weird combination of special characters and numeric characters '
        'WHEN isValidEmail() is called '
        'THEN true value of [bool] type should be returned.', () {
      // Given
      const value = '#@123.com';
      // When
      final result = StringExtension(value).isValidEmail();
      // Then
      expect(result, true);
    });

    test(
        'GIVEN a random email value of [String] type without specifying \'@\' character after the local part of the email '
        'WHEN isValidEmail() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = 'test123email.com';
      // When
      final result = StringExtension(value).isValidEmail();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN a random email value of [String] type with special characters for the domain name '
        'WHEN isValidEmail() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = 'test123@!#\$.com';
      // When
      final result = StringExtension(value).isValidEmail();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN a random email value of [String] type without specifying \'.\' character after the domain name '
        'WHEN isValidEmail() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = 'test123@emailcom';
      // When
      final result = StringExtension(value).isValidEmail();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN a random email value of [String] type with numeric characters for the top-level domain '
        'WHEN isValidEmail() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = 'test123@email.123';
      // When
      final result = StringExtension(value).isValidEmail();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN a random email value of [String] type with two specified \'@\' character '
        'WHEN isValidEmail() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = 'test123@@email.com';
      // When
      final result = StringExtension(value).isValidEmail();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN a random email value of [String] type with two specified \'.\' character '
        'WHEN isValidEmail() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = 'test123@email..com';
      // When
      final result = StringExtension(value).isValidEmail();
      // Then
      expect(result, false);
    });
  }, tags: ['mobile', 'unit']);

  group('isNumeric() group tests', () {
    test(
        'GIVEN a set of numeric value of [String] type '
        'WHEN isNumeric() is called '
        'THEN true value of [bool] type should be returned.', () {
      // Given
      const value = '123';
      // When
      final result = StringExtension(value).isNumeric();
      // Then
      expect(result, true);
    });

    test(
        'GIVEN a set of floating value of [String] type '
        'WHEN isNumeric() is called '
        'THEN true value of [bool] type should be returned.', () {
      // Given
      const value = '12.3';
      // When
      final result = StringExtension(value).isNumeric();
      // Then
      expect(result, true);
    });

    test(
        'GIVEN a set of random value of [String] type with numeric characters and alphabetical characters mixed '
        'WHEN isNumeric() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = '123ASD';
      // When
      final result = StringExtension(value).isNumeric();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN a set of numeric value of [String] type with alphabetical characters '
        'WHEN isNumeric() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = 'ASD';
      // When
      final result = StringExtension(value).isNumeric();
      // Then
      expect(result, false);
    });

    test(
        'GIVEN a set of numeric value of [String] type with special characters '
        'WHEN isNumeric() is called '
        'THEN false value of [bool] type should be returned.', () {
      // Given
      const value = '!@#';
      // When
      final result = StringExtension(value).isNumeric();
      // Then
      expect(result, false);
    });
  }, tags: ['mobile', 'unit']);

  group('parseTimeOnly() group tests', () {
    test(
        'GIVEN a DateTime value with date and time specified of [String] type '
        'WHEN parseTimeOnly() is called '
        'THEN parsed DateTime value with only time of [String] type should be returned', () {
      // Given
      const value = '2024-02-20 12:59:55.320';
      // When
      final result = value.parseTimeOnly();
      // Then
      expect(result, '12:59');
    });

    test(
        'GIVEN a DateTime value with only date specified of [String] type '
        'WHEN parseTimeOnly() is called '
        'THEN parsed DateTime value with only the default time of [String] type should be returned', () {
      // Given
      const value = '20240203';
      // When
      final result = value.parseTimeOnly();
      // Then
      expect(result, '00:00');
    });

    test(
        'GIVEN a random invalid DateTime value of [String] type '
        'WHEN parseTimeOnly() is called '
        'THEN parsed value of [String] type should be returned', () {
      // Given
      const value = 'abc123';
      // When
      final result = value.parseTimeOnly();
      // Then
      expect(result, '');
    });

    test(
        'GIVEN a null value '
        'WHEN parseTimeOnly() is called '
        'THEN a null value should be returned', () {
      // Given
      const value = null;
      // When
      final result = value?.parseTimeOnly();
      // Then
      expect(result, null);
    });

    test(
        'GIVEN a whitespace value of [String] type '
        'WHEN parseTimeOnly() is called '
        'THEN value of empty [String] type should be returned', () {
      // Given
      const value = ' ';
      // When
      final result = value.parseTimeOnly();
      // Then
      expect(result, '');
    });

    test(
        'GIVEN an empty value of [String] type '
        'WHEN parseTimeOnly() is called '
        'THEN value of empty [String] type should be returned', () {
      // Given
      const value = '';
      // When
      final result = value.parseTimeOnly();
      // Then
      expect(result, '');
    });
  }, tags: ['mobile', 'unit']);

  group('parseUTCDate() group tests', () {
    test(
        'GIVEN a DateTime value of [String] type '
        'WHEN parseUTCDate() is called '
        'THEN a parsed DateTime value of [String] type should be returned', () {
      // Given
      const value = '2024-02-20 12:59:55.320';
      // When
      final result = value.parseUTCDate();
      // Then
      expect(result, '2024-02-20 12:59:55');
    });

    test(
        'GIVEN a DateTime value of [String] type '
        'WHEN parseUTCDate() is called with a [dd MMM yyyy] dateFormat argument '
        'THEN a parsed DateTime value of [String] type should be returned', () {
      // Given
      const value = '2024-02-20 12:59:55.320';
      // When
      final result = value.parseUTCDate(dateFormat: 'dd MMM yyyy');
      // Then
      expect(result, '20 Feb 2024');
    });

    test(
        'GIVEN a DateTime value of the default format as a [String] type '
        'WHEN parseUTCDate() is called '
        'THEN the same DateTime value of [String] type should be returned', () {
      // Given
      const value = '2024-02-20 12:59:55';
      // When
      final result = value.parseUTCDate();
      // Then
      expect(result, '2024-02-20 12:59:55');
    });

    test(
        'GIVEN an invalid DateTime value of [String] type '
        'WHEN parseUTCDate() is called '
        'THEN the same DateTime value of [String] type should be returned', () {
      // Given
      const value = '2024-02-20 12:59:55......';
      // When
      final result = value.parseUTCDate();
      // Then
      expect(result, '');
    });

    test(
        'GIVEN a null value '
        'WHEN parseUTCDate() is called '
        'THEN a null value should be returned', () {
      // Given
      const value = null;
      // When
      final result = value?.parseUTCDate();
      // Then
      expect(result, null);
    });

    test(
        'GIVEN a whitespace value of [String] type '
        'WHEN parseUTCDate() is called '
        'THEN value of empty [String] type should be returned', () {
      // Given
      const value = ' ';
      // When
      final result = value.parseUTCDate();
      // Then
      expect(result, '');
    });

    test(
        'GIVEN an empty value of [String] type '
        'WHEN parseUTCDate() is called '
        'THEN value of empty [String] type should be returned', () {
      // Given
      const value = '';
      // When
      final result = value.parseUTCDate();
      // Then
      expect(result, '');
    });
  }, tags: ['mobile', 'unit']);

  group('isNullOrEmptyOrBlank group tests', () {
    test(
        'GIVEN an value of [String] type '
        'WHEN isNullOrEmptyOrBlank is called '
        'THEN a false value of [bool] type should be returned', () {
      // Given
      const value = 'test';
      // When
      final result = value.isNullOrEmptyOrBlank;
      // Then
      expect(result, false);
    });

    test(
        'GIVEN an blank of [String] type '
        'WHEN isNullOrEmptyOrBlank is called '
        'THEN a true value of [bool] type should be returned', () {
      // Given
      const value = ' ';
      // When
      final result = value.isNullOrEmptyOrBlank;
      // Then
      expect(result, true);
    });

    test(
        'GIVEN an empty of [String] type '
        'WHEN isNullOrEmptyOrBlank is called '
        'THEN a true value of [bool] type should be returned', () {
      // Given
      const value = '';
      // When
      final result = value.isNullOrEmptyOrBlank;
      // Then
      expect(result, true);
    });
  }, tags: ['mobile', 'unit']);
}

void _dateTimeParsingGroupTests() {
  group('withFormat() group tests', () {
    test(
        'GIVEN a random valid value of [DateTime] type '
        'WHEN withFormat() is called with [dd MMM yyyy] argument '
        'THEN the value of formatted [DateTime] should be returned in [String] format.', () {
      // Given
      final value = DateTime(2024, 4, 16, 3, 41, 18, 111);
      // When
      final result = value.withFormat('dd MMM yyyy hh:mm:ss a');
      // Then
      expect(result, '16 Apr 2024 03:41:18 AM');
    });

    test(
        'GIVEN a random valid value of [DateTime] type '
        'WHEN withFormat() is called with [dd MMM yyyy] argument '
        'THEN the value of formatted [DateTime] with default values should be returned in [String] format.', () {
      // Given
      final value = DateTime(2024);
      // When
      final result = value.withFormat('dd MMM yyyy hh:mm:ss a');
      // Then
      expect(result, '01 Jan 2024 12:00:00 AM');
    });

    test(
        'GIVEN a random valid value of [DateTime] type '
        'WHEN withFormat() is called with invalid argument '
        'THEN the value of invalid argument should be returned in [String] format.', () {
      // Given
      final value = DateTime(2024);
      // When
      final result = value.withFormat('123456789');
      // Then
      expect(result, '123456789');
    });
  }, tags: ['mobile', 'unit']);
}
