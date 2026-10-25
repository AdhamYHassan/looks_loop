import 'package:equatable/equatable.dart';

class PaymentMethodEntity extends Equatable {
  final String value;
  final String label;
  final String description;
  final String icon;
  final bool enabled;
  final String status;

  const PaymentMethodEntity({
    required this.value,
    required this.label,
    required this.description,
    this.icon = '',
    required this.enabled,
    required this.status,
  });

  /// Indicates whether this payment method is enabled and available for selection.
  bool get isSelectable => enabled && status.toLowerCase() == 'active';

  /// Badge indicator for non-active or disabled methods (e.g. 'COMING SOON').
  String? get badge {
    if (!enabled || status.toLowerCase() == 'coming_soon') {
      return 'COMING SOON';
    }
    return null;
  }

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
