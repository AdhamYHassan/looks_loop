import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/features/product_detail/data/models/product_detail_model.dart';

void main() {
  const jsonResponse = {
    'id': 8,
    'slug': 'mango-white-cotton-shirt',
    'name': 'White Cotton Shirt',
    'brand': {
      'id': 1,
      'name': 'MANGO',
      'slug': 'mango',
    },
    'category': 'women',
    'subcategory': 'tops',
    'price': '1450.00',
    'original_price': null,
    'discount_percentage': 0,
    'is_on_sale': false,
    'is_new': true,
    'image': 'https://images.pexels.com/photos/31977308/pexels-photo-31977308.jpeg',
    'colors': [
      {
        'id': 16,
        'name': 'Black',
        'hex': '#1a1a1a',
      }
    ],
    'rating_average': '0.00',
    'rating_count': 0,
    'is_wishlisted': false,
    'sku': 'LL-W011',
    'short_description': '',
    'description': 'A refined essential cut from soft cotton.',
    'material_care': 'Shell: 100% genuine leather.',
    'size_fit': 'Model is 178 cm and wears size S.',
    'images': [
      {
        'id': 29,
        'url': 'https://images.pexels.com/photos/31977308/pexels-photo-31977308.jpeg',
        'color_id': null,
        'alt': 'White Cotton Shirt',
        'is_primary': true,
      }
    ],
    'sizes': [
      {'id': 36, 'label': 'XS'},
      {'id': 37, 'label': 'S'},
      {'id': 38, 'label': 'M'},
      {'id': 39, 'label': 'L'},
      {'id': 40, 'label': 'XL'}
    ],
    'variants': [
      {
        'id': 76,
        'sku': 'LL-W011-BLA-XS',
        'color_id': 16,
        'size_id': 36,
        'stock': 21,
        'is_available': true,
      },
      {
        'id': 80,
        'sku': 'LL-W011-BLA-XL',
        'color_id': 16,
        'size_id': 40,
        'stock': 0,
        'is_available': false,
      }
    ],
    'in_stock': true,
    'rating_distribution': {'1': 0, '2': 0, '3': 0, '4': 0, '5': 0},
    'reviews': [],
    'related': [
      {
        'id': 20,
        'slug': 'mara-studio-white-chain-bag',
        'name': 'White Chain Bag',
        'brand': {'id': 8, 'name': 'Mara Studio', 'slug': 'mara-studio'},
        'category': 'women',
        'subcategory': 'bags',
        'price': '2450.00',
        'image': 'https://images.pexels.com/photos/27835299/test.jpeg',
      }
    ],
  };

  test('correctly parses ProductDetailModel from API JSON', () {
    final model = ProductDetailModel.fromJson(jsonResponse);

    expect(model.id, 8);
    expect(model.slug, 'mango-white-cotton-shirt');
    expect(model.brand, 'MANGO');
    expect(model.price, 1450.00);
    expect(model.colors.length, 1);
    expect(model.colors.first.hex, '0xFF1a1a1a');
    expect(model.sizes.length, 5);
    expect(model.variants.length, 2);
    expect(model.related.length, 1);
    expect(model.related.first.name, 'White Chain Bag');

    // Test variant checking logic
    expect(model.isSizeAvailableForColor(sizeId: 36, colorId: 16), isTrue);
    expect(model.isSizeAvailableForColor(sizeId: 40, colorId: 16), isFalse);
    expect(model.isSizeAvailableForColor(sizeId: 999, colorId: 16), isFalse);
  });
}
