import 'package:equatable/equatable.dart';

class ProductListArgs extends Equatable {
  final String category;
  final String subcategory;
  final String categoryTitle;
  final String subcategoryTitle;
  final List<String> initialBrands;
  final bool isBrandFilterLocked;

  const ProductListArgs({
    required this.category,
    required this.subcategory,
    this.categoryTitle = '',
    this.subcategoryTitle = '',
    this.initialBrands = const [],
    this.isBrandFilterLocked = false,
  });

  static String resolveSlug(String value, [String fallback = '']) {
    final v = value.trim().toLowerCase();
    if (v.isNotEmpty && int.tryParse(v) == null) {
      return v;
    }
    final fb = fallback
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'^(aud_|cat_|sub_)'), '')
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
    if (fb.isNotEmpty && int.tryParse(fb) == null) {
      return fb;
    }
    return v.isNotEmpty ? v : 'all';
  }

  String get categorySlug {
    if (isBrandFilterLocked || category.isEmpty) return '';
    return resolveSlug(category, categoryTitle);
  }

  String get subcategorySlug {
    if (isBrandFilterLocked || subcategory.isEmpty) return '';
    return resolveSlug(subcategory, subcategoryTitle);
  }

  @override
  List<Object?> get props => [
        category,
        subcategory,
        categoryTitle,
        subcategoryTitle,
        initialBrands,
        isBrandFilterLocked,
      ];
}
