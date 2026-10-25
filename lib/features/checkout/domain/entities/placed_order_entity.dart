import 'package:equatable/equatable.dart';

class PlacedOrderEntity extends Equatable {
  final String orderNumber;
  final String message;
  final double? total;

  const PlacedOrderEntity({
    required this.orderNumber,
    this.message = '',
    this.total,
  });

  @override
  List<Object?> get props => [orderNumber, message, total];
}
