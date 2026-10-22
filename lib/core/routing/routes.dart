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
  static const String brands = '/brands';
  static const String productList = '/product-list';
  static const String cart = '/cart';
  static const String orders = '/orders';
  static const String orderDetail = '/orders/:orderNumber';
  static String orderDetailPath(String orderNumber) => '/orders/$orderNumber';
  static const String productDetail = '/product-detail';
  static const String productDetailWithId = '/product-detail/:slug';
  static String productDetailPath(String slug) => '/product-detail/$slug';
  static const String looks = '/looks';
  static const String lookProducts = '/look-products';
  static const String checkout = '/checkout';
}
