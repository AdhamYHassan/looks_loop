enum PaymentMethod {
  cashOnDelivery(
    title: 'CASH ON DELIVERY',
    subtitle: 'Pay when your order arrives',
    isEnabled: true,
  ),
  onlinePayment(
    title: 'ONLINE PAYMENT',
    subtitle: 'Pay by card',
    isEnabled: false,
    badge: 'COMING SOON',
  );

  final String title;
  final String subtitle;
  final bool isEnabled;
  final String? badge;

  const PaymentMethod({
    required this.title,
    required this.subtitle,
    required this.isEnabled,
    this.badge,
  });
}
