enum DeliveryMethod {
  standard(
    title: 'STANDARD DELIVERY',
    subtitle: '2-4 Business Days',
    cost: 0.0,
    priceDisplay: 'FREE',
  ),
  express(
    title: 'EXPRESS DELIVERY',
    subtitle: 'Next Business Day',
    cost: 80.0,
    priceDisplay: '80 EGP',
  );

  final String title;
  final String subtitle;
  final double cost;
  final String priceDisplay;

  const DeliveryMethod({
    required this.title,
    required this.subtitle,
    required this.cost,
    required this.priceDisplay,
  });
}
