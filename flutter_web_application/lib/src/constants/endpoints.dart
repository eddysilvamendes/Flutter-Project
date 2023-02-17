const String baseUrl = "https://parseapi.back4app.com/functions";

abstract class EndPoint {
  static const String signin = "$baseUrl/login";
  static const String signup = "$baseUrl/signup";
  static const String validateToken = "$baseUrl/validate-token";
  static const String resetPassword = "$baseUrl/reset-password";
  static const String getCategory = "$baseUrl/get-category-list";
  static const String getProduct = "$baseUrl/get-product-list";
  static const String getCartItem = "$baseUrl/get-cart-item";
  static const String addCartItem = "$baseUrl/add-item-to-cart";
  static const String modifyCartItem = "$baseUrl/modify-item-quantity";
  static const String checkOut = "$baseUrl/checkout";
  static const String getOrders = "$baseUrl/get-order";
  static const String getOrderItems = "$baseUrl/get-order-items";
  static const String changePassword = "$baseUrl/change-password";
  static const String createProduct = "$baseUrl/create_product";
  static const String createCategory = "$baseUrl/create_category";
}
