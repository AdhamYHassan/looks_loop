import 'package:equatable/equatable.dart';

class DeliveryMethodEntity extends Equatable {
  final String code;
  final String name;
  final String description;
  final String icon;
  final double fee;
  final double? freeDeliveryThreshold;
  final bool usesGovernorateRates;
  final bool isDefault;

  const DeliveryMethodEntity({
    required this.code,
    required this.name,
    required this.description,
    this.icon = '',
    required this.fee,
    this.freeDeliveryThreshold,
    this.usesGovernorateRates = false,
    this.isDefault = false,
  });

  String get priceDisplay {
    if (fee == 0.0) return 'FREE';
    return '${fee.toStringAsFixed(0)} EGP';
  }

  double calculateCost(double subtotal) {
    if (freeDeliveryThreshold != null && subtotal >= freeDeliveryThreshold!) {
      return 0.0;
    }
    return fee;
  }

  @override
  List<Object?> get props => [
        code,
        name,
        description,
        icon,
        fee,
        freeDeliveryThreshold,
        usesGovernorateRates,
        isDefault,
      ];
}
