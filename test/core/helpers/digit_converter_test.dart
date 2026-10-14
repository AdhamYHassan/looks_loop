import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/helpers/digit_converter.dart';

void main() {
  group('DigitConverter', () {
    test('toEnglishDigits converts Arabic and Persian numerals to Western digits', () {
      expect(DigitConverter.toEnglishDigits('٠١٢٣٤٥٦٧٨٩'), '0123456789');
      expect(DigitConverter.toEnglishDigits('۰۱۲۳۴۵۶۷۸۹'), '0123456789');
      expect(DigitConverter.toEnglishDigits('Order #١٢٣'), 'Order #123');
      expect(DigitConverter.toEnglishDigits(''), '');
    });

    test('convertPayloadDigits converts nested Maps, Lists and FormData', () {
      final inputMap = {
        'order_id': '١٢٣',
        'items': ['٤', '٥'],
        'meta': {'code': '٦٧٨'},
      };

      final dynamic converted = DigitConverter.convertPayloadDigits(inputMap);
      expect(converted['order_id'], '123');
      expect(converted['items'], ['4', '5']);
      expect(converted['meta']['code'], '678');

      final formData = FormData.fromMap({
        'phone': '٠١٠١٢٣٤٥٦٧٨',
      });
      final dynamic convertedForm = DigitConverter.convertPayloadDigits(formData);
      expect(convertedForm, isA<FormData>());
      expect((convertedForm as FormData).fields.first.value, '01012345678');
    });
  });
}
