import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_args.dart';

void main() {
  group('ProductListArgs', () {
    test('isSale: true clears categorySlug and subcategorySlug', () {
      const args = ProductListArgs(
        category: 'clothing',
        subcategory: 'dresses',
        categoryTitle: 'CLOTHING',
        subcategoryTitle: 'DRESSES',
        isSale: true,
      );

      expect(args.isSale, isTrue);
      expect(args.categorySlug, isEmpty);
      expect(args.subcategorySlug, isEmpty);
    });

    test('isSale: false resolves normal categorySlug and subcategorySlug', () {
      const args = ProductListArgs(
        category: 'clothing',
        subcategory: 'dresses',
        categoryTitle: 'CLOTHING',
        subcategoryTitle: 'DRESSES',
        isSale: false,
      );

      expect(args.isSale, isFalse);
      expect(args.categorySlug, equals('clothing'));
      expect(args.subcategorySlug, equals('dresses'));
    });
  });
}
