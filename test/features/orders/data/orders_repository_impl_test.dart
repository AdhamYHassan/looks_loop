import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/orders/data/datasources/orders_remote_data_source.dart';
import 'package:looks_loop/features/orders/data/models/order_detail_model.dart';
import 'package:looks_loop/features/orders/data/models/orders_page_model.dart';
import 'package:looks_loop/features/orders/data/repositories/orders_repository_impl.dart';
import 'package:looks_loop/features/orders/domain/entities/order_detail_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/order_status.dart';
import 'package:looks_loop/features/orders/domain/entities/orders_page_entity.dart';

class FakeOrdersRemoteDataSource implements OrdersRemoteDataSource {
  final Future<OrdersPageModel> Function()? onGet;
  final Future<OrderDetailModel> Function(String)? onGetDetail;

  FakeOrdersRemoteDataSource({this.onGet, this.onGetDetail});

  @override
  Future<OrdersPageModel> getOrders() => onGet!();

  @override
  Future<OrderDetailModel> getOrderDetail(String orderNumber) =>
      onGetDetail!(orderNumber);
}

void main() {
  const json = {
    'data': {
      'count': 2,
      'next': null,
      'previous': null,
      'results': [
        {
          'order_number': 'LL-20261006-ID42T',
          'created': '2026-10-06T10:29:31.581257+03:00',
          'status': 'pending',
          'status_display': 'Pending',
          'total': '11770.00',
          'item_count': 7,
          'images': ['https://a.com/1.jpg', 'https://a.com/2.jpg'],
        },
        {
          'order_number': 'LL-X',
          'created': null,
          'status': 'brand_new_status',
          'status_display': 'New',
          'total': '10.50',
          'item_count': 1,
          'images': [],
        },
      ],
    },
  };

  const detailJson = {
    'data': {
      'order_number': 'LL-20261006-ID42T',
      'created': '2026-10-06T10:29:31.581257+03:00',
      'status': 'pending',
      'status_display': 'Pending',
      'status_history': [
        {
          'status': 'pending',
          'status_display': 'Pending',
          'at': '2026-10-06T07:29:31.581257Z',
        }
      ],
      'can_cancel': true,
      'full_name': 'Sara Ahmed',
      'phone': '01001234567',
      'governorate': 'Cairo',
      'city': 'Cairo',
      'area': 'Zamalek',
      'street': '26 July Street',
      'building': '12',
      'floor': '4',
      'apartment': '8',
      'address': '26 July Street, Bldg 12, Floor 4, Apt 8, Zamalek, Cairo',
      'payment_method_display': 'Cash on delivery',
      'subtotal': '11770.00',
      'product_savings': '300.00',
      'voucher_discount': '0.00',
      'delivery_fee': '0.00',
      'total': '11470.00',
      'item_count': 2,
      'vendor_orders': [
        {
          'id': 31,
          'brand': {'id': 7, 'name': 'Form / Field', 'slug': 'form-field'},
          'items': [
            {
              'id': 44,
              'product_id': 43,
              'product_slug': 'form-field-suede-boots',
              'name': 'Suede Boots',
              'variant': 'White / 42',
              'image': 'https://a.com/boots.jpg',
              'unit_price': '2100.00',
              'quantity': 2,
              'line_total': '4200.00',
            }
          ]
        }
      ]
    }
  };

  test('maps envelope, string total, date and status to entity', () async {
    final repo = OrdersRepositoryImpl(
      FakeOrdersRemoteDataSource(
        onGet: () async => OrdersPageModel.fromJson(json),
      ),
    );

    final result = await repo.getOrders();

    final page = (result as ApiSuccess<OrdersPageEntity>).data;
    expect(page.count, 2);
    expect(page.hasNext, false);
    expect(page.orders.first.total, 11770.0);
    expect(page.orders.first.status, OrderStatus.pending);
    expect(page.orders.first.createdAt, isNotNull);
    expect(page.orders.first.images.length, 2);
  });

  test('unknown status falls back and null date is tolerated', () async {
    final repo = OrdersRepositoryImpl(
      FakeOrdersRemoteDataSource(
        onGet: () async => OrdersPageModel.fromJson(json),
      ),
    );

    final result = await repo.getOrders();

    final second = (result as ApiSuccess<OrdersPageEntity>).data.orders[1];
    expect(second.status, OrderStatus.unknown);
    expect(second.createdAt, isNull);
  });

  test('returns ApiFailure when data source throws', () async {
    final repo = OrdersRepositoryImpl(
      FakeOrdersRemoteDataSource(onGet: () async => throw Exception('boom')),
    );

    final result = await repo.getOrders();

    expect(result, isA<ApiFailure<OrdersPageEntity>>());
  });

  test('getOrderDetail maps full detail payload correctly', () async {
    final repo = OrdersRepositoryImpl(
      FakeOrdersRemoteDataSource(
        onGetDetail: (_) async => OrderDetailModel.fromJson(detailJson),
      ),
    );

    final result = await repo.getOrderDetail('LL-20261006-ID42T');

    expect(result, isA<ApiSuccess<OrderDetailEntity>>());
    final detail = (result as ApiSuccess<OrderDetailEntity>).data;
    expect(detail.orderNumber, 'LL-20261006-ID42T');
    expect(detail.status, OrderStatus.pending);
    expect(detail.canCancel, true);
    expect(detail.address.fullName, 'Sara Ahmed');
    expect(detail.address.city, 'Cairo');
    expect(detail.pricing.subtotal, 11770.0);
    expect(detail.pricing.productSavings, 300.0);
    expect(detail.pricing.totalDiscount, 300.0);
    expect(detail.items.length, 1);
    expect(detail.items.first.brandName, 'Form / Field');
    expect(detail.items.first.name, 'Suede Boots');
    expect(detail.items.first.unitPrice, 2100.0);
    expect(detail.statusHistory.length, 1);
    expect(detail.statusHistory.first.status, OrderStatus.pending);
  });

  test('getOrderDetail returns ApiFailure when data source throws', () async {
    final repo = OrdersRepositoryImpl(
      FakeOrdersRemoteDataSource(
        onGetDetail: (_) async => throw Exception('detail error'),
      ),
    );

    final result = await repo.getOrderDetail('LL-X');

    expect(result, isA<ApiFailure<OrderDetailEntity>>());
  });
}

