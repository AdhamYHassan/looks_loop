/// Lifecycle states of a customer order.
///
/// [unknown] is a safe fallback so a new backend status never crashes the app.
enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
  cancelled,
  unknown;

  static OrderStatus fromApi(String? value) {
    return OrderStatus.values.firstWhere(
      (status) => status.name == value?.toLowerCase().trim(),
      orElse: () => OrderStatus.unknown,
    );
  }

  /// Orders that are still in progress (not finished or cancelled).
  bool get isActive =>
      this == pending ||
      this == confirmed ||
      this == processing ||
      this == shipped;
}
