import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/helpers/app_formatters.dart';

void main() {
  group('AppFormatters.shortDate', () {
    test('formats English dates correctly', () {
      final date = DateTime(2026, 10, 6);
      expect(AppFormatters.shortDate(date, 'en'), '6 Oct 2026');
    });

    test('formats Arabic dates correctly', () {
      final date = DateTime(2026, 10, 6);
      expect(AppFormatters.shortDate(date, 'ar'), '6 أكتوبر 2026');
    });
  });

  group('AppFormatters.amount', () {
    test('formats whole numbers with commas and no decimals', () {
      expect(AppFormatters.amount(11770.0), '11,770');
      expect(AppFormatters.amount(1000000.0), '1,000,000');
      expect(AppFormatters.amount(0.0), '0');
    });

    test('formats fractional numbers with two decimals', () {
      expect(AppFormatters.amount(11770.50), '11,770.50');
      expect(AppFormatters.amount(12.34), '12.34');
    });
  });
}
