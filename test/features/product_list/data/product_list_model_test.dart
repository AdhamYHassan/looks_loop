import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/features/product_list/data/models/product_list_model.dart';

void main() {
  final sampleJson = {
    'count': 3,
    'page': 1,
    'num_pages': 3,
    'next_page': 2,
    'sort': 'recommended',
    'sort_options': [
      {'value': 'recommended', 'label': 'RECOMMENDED'},
      {'value': 'newest', 'label': 'NEWEST'},
    ],
    'selected': {
      'brands': [],
      'sizes': [],
      'colors': [],
      'sale': false,
    },
    'facets': {
      'brands': [
        {'slug': 'zara', 'name': 'ZARA', 'count': 1},
        {'slug': 'mango', 'name': 'MANGO', 'count': 2},
      ],
      'sizes': ['XS', 'S', 'M', 'L'],
      'colors': [
        {'hex': '#1a1a1a', 'name': 'Black'},
        {'hex': '#e8e8e8', 'name': 'White'},
      ],
    },
    'results': [
      {
        'id': 49,
        'slug': 'zara-layered-casual-set',
        'name': 'Layered Casual Set',
        'brand': {'id': 2, 'name': 'ZARA', 'slug': 'zara'},
        'category': 'men',
        'subcategory': 'clothing',
        'price': '2200.00',
        'original_price': null,
        'discount_percentage': 0,
        'is_on_sale': false,
        'is_new': false,
        'image': 'https://images.pexels.com/photos/6616673/pexels.jpg',
        'colors': [
          {'id': 81, 'name': 'Black', 'hex': '#000000'},
        ],
        'rating_avg': '4.50',
        'rating_count': 12,
        'is_wishlisted': false,
      },
    ],
  };

  test('ProductListModel correctly parses sample JSON with color facet objects', () {
    final model = ProductListModel.fromJson(sampleJson);

    expect(model.count, 3);
    expect(model.page, 1);
    expect(model.numPages, 3);
    expect(model.nextPage, 2);
    expect(model.sort, 'recommended');
    expect(model.sortOptions.length, 2);
    expect(model.sortOptions.first.value, 'recommended');
    expect(model.facets.brands.length, 2);
    expect(model.facets.sizes, contains('XS'));
    expect(model.facets.colors.length, 2);
    expect(model.facets.colors.first.name, 'Black');
    expect(model.facets.colors.first.hex, '#1a1a1a');
    expect(model.results.length, 1);
    expect(model.results.first.slug, 'zara-layered-casual-set');
    expect(model.results.first.brand, 'ZARA');
    expect(model.results.first.price, 2200.0);
  });
}
