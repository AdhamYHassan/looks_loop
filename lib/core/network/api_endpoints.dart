class ApiEndpoints {
  static const String baseUrl = 'https://look-loops.codebee.site/api/v1/';
  static const String login = 'auth/login/';
  static const String register = 'auth/register/';
  static const String logout = 'auth/logout/';
  static const String addresses = 'me/addresses/';
  static const String orders = 'orders/';
  static const String home = 'home/';
  static const String provincesNested = 'provinces/nested/?country=1';
  static const String wishlist = 'wishlist/';
  static const String products = 'products/';
  static const String cart = 'cart/';
  static const String cartItems = 'cart/items/';
  static const String looks = 'looks/';
  static String lookDetail(String slug) => 'looks/$slug/';
}

