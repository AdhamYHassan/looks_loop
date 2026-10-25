import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/orders/domain/usecases/cancel_order_usecase.dart';
import 'package:looks_loop/features/orders/domain/usecases/get_order_detail_usecase.dart';
import 'package:looks_loop/features/orders/presentation/bloc/order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  final GetOrderDetailUseCase _getOrderDetailUseCase;
  final CancelOrderUseCase _cancelOrderUseCase;

  OrderDetailCubit(
    this._getOrderDetailUseCase,
    this._cancelOrderUseCase,
  ) : super(const OrderDetailInitial());

  Future<void> loadOrderDetail(String orderNumber) async {
    emit(const OrderDetailLoading());
    final result = await _getOrderDetailUseCase(orderNumber);
    switch (result) {
      case ApiSuccess(:final data):
        emit(OrderDetailLoaded(data));
      case ApiFailure(:final failure):
        emit(OrderDetailError(failure.message));
    }
  }

  Future<bool> cancelOrder(String orderNumber) async {
    final curr = state;
    if (curr is! OrderDetailLoaded) return false;

    emit(curr.copyWith(isCancelling: true, cancelError: () => null));

    final result = await _cancelOrderUseCase(orderNumber);
    switch (result) {
      case ApiSuccess(:final data):
        emit(OrderDetailLoaded(data));
        return true;
      case ApiFailure(:final failure):
        emit(curr.copyWith(
          isCancelling: false,
          cancelError: () => failure.message,
        ));
        return false;
    }
  }
}
