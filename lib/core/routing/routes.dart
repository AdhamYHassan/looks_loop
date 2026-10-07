class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String home = '/home';
  static const String shop = '/shop';
  static const String wishlist = '/wishlist';
  static const String more = '/more';
  static const String categoryDetail = '/category-detail';
  static const String cart = '/cart';
  static const String orders = '/orders';
  static const String orderDetail = '/orders/:orderNumber';
  static String orderDetailPath(String orderNumber) => '/orders/$orderNumber';
}
