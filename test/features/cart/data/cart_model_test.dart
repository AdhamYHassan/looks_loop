import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/features/cart/data/models/cart_item_model.dart';
import 'package:looks_loop/features/cart/data/models/cart_model.dart';

void main() {
  final sampleResponse = {
    "status": true,
    "status_code": 200,
    "message": "success",
    "data": {
      "cart_token": "app_d12ec900ead7f104c42d806f51ffe5d3",
      "lines": [
        {
          "id": 150,
          "quantity": 1,
          "max_quantity": 21,
          "unit_price": "1450.00",
          "original_unit_price": null,
          "line_total": "1450.00",
          "product": {
            "id": 8,
            "slug": "mango-white-cotton-shirt",
            "name": "White Cotton Shirt",
            "brand": {
              "id": 1,
              "name": "MANGO",
              "slug": "mango",
            },
            "image":
                "https://images.pexels.com/photos/31977308/pexels-photo-31977308.jpeg?auto=compress&cs=tinysrgb&w=900",
          },
          "variant": {
            "id": 76,
            "sku": "LL-W011-BLA-XS",
            "stock": 21,
            "color": {
              "id": 16,
              "name": "Black",
              "hex": "#1a1a1a",
            },
            "size": {
              "id": 36,
              "label": "XS",
            },
          },
        }
      ],
      "count": 1,
      "subtotal": "1450.00",
      "savings": "0.00",
      "voucher": null,
      "voucher_error": "",
      "voucher_discount": "0.00",
      "delivery": "100.00",
      "free_delivery_threshold": "2000.00",
      "delivery_province": null,
      "remaining_for_free_delivery": "550.00",
      "total": "1550.00",
      "message": "",
    },
  };

  test('CartModel.fromJson parses backend cart payload correctly', () {
    final data = sampleResponse['data'] as Map<String, dynamic>;
    final model = CartModel.fromJson(data);

    expect(model.items.length, 1);
    final item = model.items.first;
    expect(item.id, '150');
    expect(item.productId, '8');
    expect(item.slug, 'mango-white-cotton-shirt');
    expect(item.name, 'White Cotton Shirt');
    expect(item.brand, 'MANGO');
    expect(item.variantDescription, 'Black / XS');
    expect(item.price, 1450.0);
    expect(item.quantity, 1);

    expect(model.summary.subtotal, 1450.0);
    expect(model.summary.deliveryText, '100 EGP');
    expect(model.summary.total, 1550.0);
  });

  test('CartItemModel.fromJson handles direct and nested properties', () {
    final data = sampleResponse['data'] as Map<String, dynamic>;
    final line = (data['lines'] as List).first as Map<String, dynamic>;
    final item = CartItemModel.fromJson(line);

    expect(item.id, '150');
    expect(item.name, 'White Cotton Shirt');
    expect(item.brand, 'MANGO');
    expect(item.variantDescription, 'Black / XS');
  });

  test('CartModel.fromJson parses applied voucher object correctly', () {
    final voucherData = {
      'lines': [],
      'subtotal': '1450.00',
      'voucher': {
        'code': 'WELCOME200',
        'label': '200 EGP OFF',
      },
      'voucher_discount': '200.00',
      'delivery': '100.00',
      'total': '1350.00',
    };
    final model = CartModel.fromJson(voucherData);

    expect(model.appliedPromoCode, 'WELCOME200');
    expect(model.discountAmount, 200.0);
    expect(model.summary.discount, 200.0);
    expect(model.summary.total, 1350.0);
  });
}
