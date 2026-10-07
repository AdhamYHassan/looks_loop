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

  const OrderDetailLoaded(this.order);

  @override
  List<Object?> get props => [order];
}

final class OrderDetailError extends OrderDetailState {
  final String message;

  const OrderDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
