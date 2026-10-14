import 'package:dio/dio.dart';

/// Utility to convert Eastern Arabic (and Persian) numerals to Western English numerals.
class DigitConverter {
  DigitConverter._();

  static const Map<String, String> _arabicToEnglishMap = {
    '٠': '0', '١': '1', '٢': '2', '٣': '3', '٤': '4',
    '٥': '5', '٦': '6', '٧': '7', '٨': '8', '٩': '9',
    '۰': '0', '۱': '1', '۲': '2', '۳': '3', '۴': '4',
    '۵': '5', '۶': '6', '۷': '7', '۸': '8', '۹': '9',
  };

  /// Converts any Arabic/Persian digits in [input] to standard English digits.
  static String toEnglishDigits(String input) {
    if (input.isEmpty) return input;
    final buffer = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      final char = input[i];
      buffer.write(_arabicToEnglishMap[char] ?? char);
    }
    return buffer.toString();
  }

  /// Recursively converts Arabic digits in dynamic structures (String, Map, List, FormData).
  static dynamic convertPayloadDigits(dynamic data) {
    if (data is String) {
      return toEnglishDigits(data);
    } else if (data is Map) {
      final result = <String, dynamic>{};
      data.forEach((key, value) {
        result[key.toString()] = convertPayloadDigits(value);
      });
      return result;
    } else if (data is List) {
      return data.map((item) => convertPayloadDigits(item)).toList();
    } else if (data is FormData) {
      final updatedFields = data.fields
          .map((e) => MapEntry(e.key, toEnglishDigits(e.value)))
          .toList();
      data.fields.clear();
      data.fields.addAll(updatedFields);
      return data;
    }
    return data;
  }
}
