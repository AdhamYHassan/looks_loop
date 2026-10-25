import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/orders/domain/entities/order_detail_entity.dart';

sealed class OrderDetailState extends Equatable {
  const OrderDetailState();

  @override
  List<Object?> get props => [];
}

final class OrderDetailInitial extends OrderDetailState {
  const OrderDetailInitial();
}

final class OrderDetailLoading extends OrderDetailState {
  const OrderDetailLoading();
}

final class OrderDetailLoaded extends OrderDetailState {
  final OrderDetailEntity order;
  final bool isCancelling;
  final String? cancelError;

  const OrderDetailLoaded(
    this.order, {
    this.isCancelling = false,
    this.cancelError,
  });

  OrderDetailLoaded copyWith({
    OrderDetailEntity? order,
    bool? isCancelling,
    String? Function()? cancelError,
  }) {
    return OrderDetailLoaded(
      order ?? this.order,
      isCancelling: isCancelling ?? this.isCancelling,
      cancelError: cancelError != null ? cancelError() : this.cancelError,
    );
  }

  @override
  List<Object?> get props => [order, isCancelling, cancelError];
}

final class OrderDetailError extends OrderDetailState {
  final String message;

  const OrderDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
