import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/checkout/domain/entities/payment_method_entity.dart';

class PaymentMethodModel extends Equatable {
  final String value;
  final String label;
  final String description;
  final String icon;
  final bool enabled;
  final String status;

  const PaymentMethodModel({
    required this.value,
    required this.label,
    required this.description,
    this.icon = '',
    required this.enabled,
    required this.status,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      value: json['value'] as String? ?? '',
      label: json['label'] as String? ?? '',
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      enabled: json['enabled'] as bool? ?? false,
      status: json['status'] as String? ?? 'coming_soon',
    );
  }

  Map<String, dynamic> toJson() => {
        'value': value,
        'label': label,
        'description': description,
        'icon': icon,
        'enabled': enabled,
        'status': status,
      };

  PaymentMethodEntity toEntity() => PaymentMethodEntity(
        value: value,
        label: label,
        description: description,
        icon: icon,
        enabled: enabled,
        status: status,
      );

  @override
  List<Object?> get props => [
        value,
        label,
        description,
        icon,
        enabled,
        status,
      ];
}
