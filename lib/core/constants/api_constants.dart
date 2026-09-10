class ApiConstants {
  static const String baseUrl = 'https://outmesmart.codeedextechnologies.com';


  // authentication
  static const String requestOtp = '$baseUrl/api/v1/customer/auth/otp/request';
  static const String verifyOtp = '$baseUrl/api/v1/customer/auth/otp/verify';
  static const String refreshToken = '$baseUrl/api/v1/customer/auth/refresh';
  static const String logout = '$baseUrl/api/v1/customer/auth/logout';

//   home page set up

  static const String storeCategories = '$baseUrl/api/v1/customer/store-categories';
  static const String nearbyStores = '$baseUrl/api/v1/customer/stores/nearby';
  static const String trendingProducts ='$baseUrl/api/v1/customer/offers/trending';

//   cart section

  static const String cart ='$baseUrl/api/v1/customer/cart';
  static String cartbystore(String storeId) => '$cart/$storeId';
  static String cartSummary(String storeId) => '$cart/$storeId/summary';
  static const String cartItems = '$cart/items';


}