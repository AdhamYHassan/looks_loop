/// Shared lightweight formatters (avoids a direct `intl` dependency).
class AppFormatters {
  AppFormatters._();

  static const _monthsEn = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static const _monthsAr = [
    'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
    'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
  ];

  /// e.g. `6 Oct 2026` / `6 أكتوبر 2026`.
  static String shortDate(DateTime date, String languageCode) {
    final local = date.toLocal();
    final months = languageCode == 'ar' ? _monthsAr : _monthsEn;
    return '${local.day} ${months[local.month - 1]} ${local.year}';
  }

  /// e.g. `11,770` or `10.50` (decimals shown only when not whole).
  static String amount(double value) {
    final isWhole = value == value.roundToDouble();
    final fixed = value.toStringAsFixed(isWhole ? 0 : 2);
    final parts = fixed.split('.');
    final grouped = parts.first.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => ',',
    );
    return parts.length > 1 ? '$grouped.${parts.last}' : grouped;
  }
}
