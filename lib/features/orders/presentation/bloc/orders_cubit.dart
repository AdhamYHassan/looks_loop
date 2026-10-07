import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/orders/domain/entities/orders_page_entity.dart';
import 'package:looks_loop/features/orders/domain/usecases/get_orders_usecase.dart';
import 'package:looks_loop/features/orders/presentation/bloc/orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;

  OrdersCubit(this._getOrdersUseCase) : super(const OrdersInitial());

  Future<void> loadOrders() async {
    emit(const OrdersLoading());

    final result = await _getOrdersUseCase();

    switch (result) {
      case ApiSuccess<OrdersPageEntity>(:final data):
        emit(OrdersLoaded(data.orders));
      case ApiFailure<OrdersPageEntity>(:final failure):
        emit(OrdersError(failure.message));
    }
  }
}
