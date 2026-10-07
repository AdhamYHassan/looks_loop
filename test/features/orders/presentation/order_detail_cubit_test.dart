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
import 'package:looks_loop/features/orders/presentation/bloc/order_detail_cubit.dart';
import 'package:looks_loop/features/orders/presentation/bloc/order_detail_state.dart';

class FakeOrdersRepository implements OrdersRepository {
  final ApiResult<OrderDetailEntity> detailResult;

  FakeOrdersRepository(this.detailResult);

  @override
  Future<ApiResult<OrdersPageEntity>> getOrders() => throw UnimplementedError();

  @override
  Future<ApiResult<OrderDetailEntity>> getOrderDetail(String orderNumber) async =>
      detailResult;
}

void main() {
  const dummyDetail = OrderDetailEntity(
    orderNumber: 'LL-10248',
    status: OrderStatus.shipped,
    statusDisplay: 'Shipped',
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

  test('emits [Loading, Loaded] on success', () async {
    final cubit = OrderDetailCubit(
      GetOrderDetailUseCase(FakeOrdersRepository(const ApiSuccess(dummyDetail))),
    );

    expectLater(
      cubit.stream,
      emitsInOrder([
        const OrderDetailLoading(),
        const OrderDetailLoaded(dummyDetail),
      ]),
    );

    await cubit.loadOrderDetail('LL-10248');
  });

  test('emits [Loading, Error] on failure', () async {
    final cubit = OrderDetailCubit(
      GetOrderDetailUseCase(
        FakeOrdersRepository(const ApiFailure(ServerFailure('Order Not Found'))),
      ),
    );

    expectLater(
      cubit.stream,
      emitsInOrder([
        const OrderDetailLoading(),
        const OrderDetailError('Order Not Found'),
      ]),
    );

    await cubit.loadOrderDetail('LL-10248');
  });
}
