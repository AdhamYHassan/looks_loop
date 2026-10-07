import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/orders/domain/usecases/get_order_detail_usecase.dart';
import 'package:looks_loop/features/orders/presentation/bloc/order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  final GetOrderDetailUseCase _getOrderDetailUseCase;

  OrderDetailCubit(this._getOrderDetailUseCase)
      : super(const OrderDetailInitial());

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
}
