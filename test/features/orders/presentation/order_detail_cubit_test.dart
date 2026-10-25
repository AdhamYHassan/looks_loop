import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/orders/domain/entities/order_address_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/order_detail_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/order_pricing_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/order_status.dart';
import 'package:looks_loop/features/orders/domain/entities/orders_page_entity.dart';
import 'package:looks_loop/features/orders/domain/repositories/orders_repository.dart';
import 'package:looks_loop/features/orders/domain/usecases/cancel_order_usecase.dart';
import 'package:looks_loop/features/orders/domain/usecases/get_order_detail_usecase.dart';
import 'package:looks_loop/features/orders/presentation/bloc/order_detail_cubit.dart';
import 'package:looks_loop/features/orders/presentation/bloc/order_detail_state.dart';

class FakeOrdersRepository implements OrdersRepository {
  final ApiResult<OrderDetailEntity> detailResult;
  final ApiResult<OrderDetailEntity>? cancelResult;

  FakeOrdersRepository(this.detailResult, [this.cancelResult]);

  @override
  Future<ApiResult<OrdersPageEntity>> getOrders() => throw UnimplementedError();

  @override
  Future<ApiResult<OrderDetailEntity>> getOrderDetail(
    String orderNumber,
  ) async =>
      detailResult;

  @override
  Future<ApiResult<OrderDetailEntity>> cancelOrder(String orderNumber) async =>
      cancelResult ?? detailResult;
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

  const cancelledDetail = OrderDetailEntity(
    orderNumber: 'LL-10248',
    status: OrderStatus.cancelled,
    statusDisplay: 'Cancelled',
    statusHistory: [],
    canCancel: false,
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

  test('loadOrderDetail emits [Loading, Loaded] on success', () async {
    final repo = FakeOrdersRepository(const ApiSuccess(dummyDetail));
    final cubit = OrderDetailCubit(
      GetOrderDetailUseCase(repo),
      CancelOrderUseCase(repo),
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

  test('loadOrderDetail emits [Loading, Error] on failure', () async {
    final repo = FakeOrdersRepository(
      const ApiFailure(ServerFailure('Order Not Found')),
    );
    final cubit = OrderDetailCubit(
      GetOrderDetailUseCase(repo),
      CancelOrderUseCase(repo),
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

  test('cancelOrder succeeds and updates state with cancelled order', () async {
    final repo = FakeOrdersRepository(
      const ApiSuccess(dummyDetail),
      const ApiSuccess(cancelledDetail),
    );
    final cubit = OrderDetailCubit(
      GetOrderDetailUseCase(repo),
      CancelOrderUseCase(repo),
    );

    await cubit.loadOrderDetail('LL-10248');

    expectLater(
      cubit.stream,
      emitsInOrder([
        const OrderDetailLoaded(dummyDetail, isCancelling: true),
        const OrderDetailLoaded(cancelledDetail, isCancelling: false),
      ]),
    );

    final result = await cubit.cancelOrder('LL-10248');
    expect(result, isTrue);
  });

  test('cancelOrder fails and updates state with error message', () async {
    final repo = FakeOrdersRepository(
      const ApiSuccess(dummyDetail),
      const ApiFailure(ServerFailure('Cannot cancel order')),
    );
    final cubit = OrderDetailCubit(
      GetOrderDetailUseCase(repo),
      CancelOrderUseCase(repo),
    );

    await cubit.loadOrderDetail('LL-10248');

    expectLater(
      cubit.stream,
      emitsInOrder([
        const OrderDetailLoaded(dummyDetail, isCancelling: true),
        const OrderDetailLoaded(
          dummyDetail,
          isCancelling: false,
          cancelError: 'Cannot cancel order',
        ),
      ]),
    );

    final result = await cubit.cancelOrder('LL-10248');
    expect(result, isFalse);
  });
}
