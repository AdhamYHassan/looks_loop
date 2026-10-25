import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/checkout/domain/entities/delivery_method_entity.dart';

class DeliveryMethodModel extends Equatable {
  final String code;
  final String name;
  final String description;
  final String icon;
  final double fee;
  final double? freeDeliveryThreshold;
  final bool usesGovernorateRates;
  final bool isDefault;

  const DeliveryMethodModel({
    required this.code,
    required this.name,
    required this.description,
    required this.icon,
    required this.fee,
    this.freeDeliveryThreshold,
    required this.usesGovernorateRates,
    required this.isDefault,
  });

  factory DeliveryMethodModel.fromJson(Map<String, dynamic> json) {
    return DeliveryMethodModel(
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      fee: _parseDouble(json['fee']),
      freeDeliveryThreshold: _parseNullableDouble(json['free_delivery_threshold']),
      usesGovernorateRates: json['uses_governorate_rates'] as bool? ?? false,
      isDefault: json['is_default'] as bool? ?? false,
    );
  }

  static double _parseDouble(dynamic val) {
    if (val == null) return 0.0;
    if (val is num) return val.toDouble();
    if (val is String) return double.tryParse(val) ?? 0.0;
    return 0.0;
  }

  static double? _parseNullableDouble(dynamic val) {
    if (val == null) return null;
    if (val is num) return val.toDouble();
    if (val is String) return double.tryParse(val);
    return null;
  }

  DeliveryMethodEntity toEntity() {
    return DeliveryMethodEntity(
      code: code,
      name: name,
      description: description,
      icon: icon,
      fee: fee,
      freeDeliveryThreshold: freeDeliveryThreshold,
      usesGovernorateRates: usesGovernorateRates,
      isDefault: isDefault,
    );
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
