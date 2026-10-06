import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/helpers/password_validator.dart';

void main() {
  group('PasswordValidator Unit Tests', () {
    test('returns invalid result when password is empty', () {
      final result = PasswordValidator.validate(password: '');
      expect(result.isValid, isFalse);
      expect(result.hasMinLength, isFalse);
    });

    test('flags password shorter than 8 characters', () {
      final result = PasswordValidator.validate(password: 'Pass1');
      expect(result.hasMinLength, isFalse);
      expect(result.isValid, isFalse);
    });

    test('flags entirely numeric password', () {
      final result = PasswordValidator.validate(password: '9876543210');
      expect(result.hasMinLength, isTrue);
      expect(result.notEntirelyNumeric, isFalse);
      expect(result.isValid, isFalse);
    });

    test('flags common passwords', () {
      final result = PasswordValidator.validate(password: 'password123');
      expect(result.notCommon, isFalse);
      expect(result.isValid, isFalse);
    });

    test('flags password that is essentially only the user name', () {
      final result = PasswordValidator.validate(
        password: 'Ahmed12',
        name: 'Ahmed',
        phone: '01001234567',
        email: 'ahmed@test.com',
      );
      expect(result.notSimilarToPersonalInfo, isFalse);
      expect(result.isValid, isFalse);
    });

    test('flags password that is similar to email username (e.g. adhamxhassan123 with adhamxhassan45@gmail.com)', () {
      final result = PasswordValidator.validate(
        password: 'adhamxhassan123',
        name: 'Adham Yasser',
        phone: '01009876543',
        email: 'adhamxhassan45@gmail.com',
      );
      expect(result.notSimilarToPersonalInfo, isFalse);
      expect(result.isValid, isFalse);
    });

    test('accepts strong password dissimilar to email and name', () {
      final result = PasswordValidator.validate(
        password: 'Zk9#mP82xL!99',
        name: 'Adham Yasser',
        phone: '01007951864',
        email: 'adhamxhassan45@gmail.com',
      );
      expect(result.hasMinLength, isTrue);
      expect(result.notEntirelyNumeric, isTrue);
      expect(result.notCommon, isTrue);
      expect(result.notSimilarToPersonalInfo, isTrue);
      expect(result.isValid, isTrue);
    });
  });
}
