import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/orders/domain/entities/order_address_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/order_detail_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/order_pricing_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/order_status.dart';
import 'package:looks_loop/features/orders/domain/entities/orders_page_entity.dart';
import 'package:looks_loop/features/orders/domain/repositories/orders_repository.dart';
import 'package:looks_loop/features/orders/domain/usecases/get_order_detail_usecase.dart';

class _FakeOrdersRepository implements OrdersRepository {
  ApiResult<OrderDetailEntity>? detailResult;

  @override
  Future<ApiResult<OrdersPageEntity>> getOrders() => throw UnimplementedError();

  @override
  Future<ApiResult<OrderDetailEntity>> getOrderDetail(String orderNumber) async {
    return detailResult!;
  }
}

void main() {
  late _FakeOrdersRepository repo;
  late GetOrderDetailUseCase useCase;

  setUp(() {
    repo = _FakeOrdersRepository();
    useCase = GetOrderDetailUseCase(repo);
  });

  const dummyDetail = OrderDetailEntity(
    orderNumber: 'LL-10248',
    status: OrderStatus.pending,
    statusDisplay: 'Pending',
    statusHistory: [],
    canCancel: true,
    address: OrderAddressEntity(
      fullName: 'Ahmed',
      phone: '0100',
      street: 'Street',
      building: '1',
      floor: '2',
      apartment: '3',
      area: 'Area',
      city: 'Cairo',
      fullAddress: 'Full Address',
    ),
    paymentMethodDisplay: 'Cash on delivery',
    pricing: OrderPricingEntity(
      subtotal: 100,
      productSavings: 0,
      voucherDiscount: 0,
      deliveryFee: 0,
      total: 100,
    ),
    items: [],
    itemCount: 0,
  );

  test('returns ApiSuccess when repository succeeds', () async {
    repo.detailResult = const ApiSuccess(dummyDetail);
    final result = await useCase('LL-10248');

    expect(result, isA<ApiSuccess<OrderDetailEntity>>());
    expect((result as ApiSuccess<OrderDetailEntity>).data.orderNumber, 'LL-10248');
  });

  test('returns ApiFailure when repository fails', () async {
    repo.detailResult = const ApiFailure(
      ServerFailure('Not found', statusCode: 404),
    );
    final result = await useCase('LL-10248');

    expect(result, isA<ApiFailure<OrderDetailEntity>>());
  });
}
