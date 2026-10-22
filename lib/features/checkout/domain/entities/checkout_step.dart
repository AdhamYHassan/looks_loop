enum CheckoutStep {
  address(label: 'ADDRESS', title: 'DELIVERY ADDRESS'),
  delivery(label: 'DELIVERY', title: 'DELIVERY METHOD'),
  payment(label: 'PAYMENT', title: 'PAYMENT METHOD'),
  review(label: 'REVIEW', title: 'REVIEW YOUR ORDER');

  final String label;
  final String title;

  const CheckoutStep({
    required this.label,
    required this.title,
  });

  bool isDone(CheckoutStep current) => index < current.index;
  bool isActive(CheckoutStep current) => index == current.index;
}
