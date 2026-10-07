import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/orders/domain/entities/order_detail_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/order_status.dart';
import 'package:looks_loop/features/orders/domain/entities/order_summary_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/orders_page_entity.dart';
import 'package:looks_loop/features/orders/domain/repositories/orders_repository.dart';
import 'package:looks_loop/features/orders/domain/usecases/get_orders_usecase.dart';
import 'package:looks_loop/features/orders/presentation/bloc/orders_cubit.dart';
import 'package:looks_loop/features/orders/presentation/bloc/orders_state.dart';

class FakeOrdersRepository implements OrdersRepository {
  final ApiResult<OrdersPageEntity> result;

  FakeOrdersRepository(this.result);

  @override
  Future<ApiResult<OrdersPageEntity>> getOrders() async => result;

  @override
  Future<ApiResult<OrderDetailEntity>> getOrderDetail(String orderNumber) =>
      throw UnimplementedError();
}

void main() {
  const order = OrderSummaryEntity(
    orderNumber: 'LL-1',
    createdAt: null,
    status: OrderStatus.pending,
    statusDisplay: 'Pending',
    total: 100,
    itemCount: 1,
    images: [],
  );

  test('emits [Loading, Loaded] on success', () async {
    final cubit = OrdersCubit(
      GetOrdersUseCase(
        FakeOrdersRepository(
          const ApiSuccess(
            OrdersPageEntity(count: 1, hasNext: false, orders: [order]),
          ),
        ),
      ),
    );

    expectLater(
      cubit.stream,
      emitsInOrder([const OrdersLoading(), const OrdersLoaded([order])]),
    );

    await cubit.loadOrders();
  });

  test('emits [Loading, Error] on failure', () async {
    final cubit = OrdersCubit(
      GetOrdersUseCase(
        FakeOrdersRepository(const ApiFailure(ServerFailure('Server Error'))),
      ),
    );

    expectLater(
      cubit.stream,
      emitsInOrder([const OrdersLoading(), const OrdersError('Server Error')]),
    );

    await cubit.loadOrders();
  });
}
