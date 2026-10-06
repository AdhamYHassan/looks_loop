import 'package:equatable/equatable.dart';

/// Immutable evaluation result for password requirements.
class PasswordValidationResult extends Equatable {
  final bool hasMinLength;
  final bool notEntirelyNumeric;
  final bool notCommon;
  final bool notSimilarToPersonalInfo;

  const PasswordValidationResult({
    required this.hasMinLength,
    required this.notEntirelyNumeric,
    required this.notCommon,
    required this.notSimilarToPersonalInfo,
  });

  const PasswordValidationResult.initial()
    : hasMinLength = false,
      notEntirelyNumeric = false,
      notCommon = false,
      notSimilarToPersonalInfo = false;

  bool get isValid =>
      hasMinLength &&
      notEntirelyNumeric &&
      notCommon &&
      notSimilarToPersonalInfo;

  @override
  List<Object?> get props => [
    hasMinLength,
    notEntirelyNumeric,
    notCommon,
    notSimilarToPersonalInfo,
  ];
}

/// Helper performing client-side security validation on passwords.
class PasswordValidator {
  PasswordValidator._();

  static const Set<String> _commonPasswords = {
    'password',
    'password123',
    '12345678',
    '123456789',
    '1234567890',
    'qwertyuiop',
    'asdfghjkl',
    'zxcvbnm',
    'admin123',
    'admin1234',
    'welcome1',
    'welcome123',
    'pass1234',
    'letmein123',
    '00000000',
    '11111111',
  };

  static PasswordValidationResult validate({
    required String password,
    String? name,
    String? phone,
    String? email,
  }) {
    final trimmed = password.trim();

    if (trimmed.isEmpty) {
      return const PasswordValidationResult.initial();
    }

    final hasMinLength = trimmed.length >= 8;
    final isAllDigits = RegExp(r'^\d+$').hasMatch(trimmed);
    final notEntirelyNumeric = hasMinLength && !isAllDigits;
    final notCommon = !_commonPasswords.contains(trimmed.toLowerCase());

    final notSimilar = _checkNotSimilarToPersonalInfo(
      password: trimmed,
      name: name,
      phone: phone,
      email: email,
    );

    return PasswordValidationResult(
      hasMinLength: hasMinLength,
      notEntirelyNumeric: notEntirelyNumeric,
      notCommon: notCommon,
      notSimilarToPersonalInfo: notSimilar,
    );
  }

  static bool _checkNotSimilarToPersonalInfo({
    required String password,
    String? name,
    String? phone,
    String? email,
  }) {
    final lowerPass = password.toLowerCase();
    final passLen = lowerPass.length;
    if (passLen == 0) return true;

    final basePassAlpha = lowerPass.replaceAll(RegExp(r'\d+'), '');

    // Collect all candidate personal info tokens from name and email
    final Set<String> candidateTokens = {};

    if (name != null && name.trim().isNotEmpty) {
      final cleanFullName = name.toLowerCase().replaceAll(RegExp(r'\s+'), '');
      if (cleanFullName.length >= 3) candidateTokens.add(cleanFullName);

      final nameParts = name.toLowerCase().split(RegExp(r'[\s\.\-_]+'));
      for (final part in nameParts) {
        if (part.length >= 3) candidateTokens.add(part);
      }
    }

    if (email != null && email.contains('@')) {
      final emailUser = email.split('@').first.toLowerCase();
      if (emailUser.length >= 3) {
        candidateTokens.add(emailUser);
        final strippedUser = emailUser.replaceAll(RegExp(r'\d+$'), '');
        if (strippedUser.length >= 3) candidateTokens.add(strippedUser);
      }

      final emailParts = emailUser.split(RegExp(r'[\s\.\-_]+'));
      for (final part in emailParts) {
        final strippedPart = part.replaceAll(RegExp(r'\d+$'), '');
        if (part.length >= 3) candidateTokens.add(part);
        if (strippedPart.length >= 3) candidateTokens.add(strippedPart);
      }
    }

    for (final token in candidateTokens) {
      if (token.length < 3) continue;

      // Exact match
      if (lowerPass == token) return false;

      // Password is only this personal token with trailing/leading digits
      if (basePassAlpha == token && token.length >= 3) return false;

      // Token dominates the password (>= 60% of total length)
      if (lowerPass.contains(token) && (token.length / passLen >= 0.6)) {
        return false;
      }
    }

    // Check against phone number digits
    if (phone != null && phone.trim().isNotEmpty) {
      final cleanPhone = phone.replaceAll(RegExp(r'\D'), '');
      if (cleanPhone.length >= 7 && lowerPass.contains(cleanPhone)) {
        return false;
      }
    }

    return true;
  }
}
