class ApiConstants {
  static String appUrl = "https://tulsihotel.net/api/v1";

  // static String appUrl = "https://dev.otmsystem.com/api/v1";
  // static String appUrl = "https://otmsystem.com/api/v1";

  static String accessToken = "";
  static const CODE_NO_INTERNET_CONNECTION = 10000;

  static Map<String, String> getHeader() {
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };
  }

  //login
  static String loginUrl = '$appUrl/tulsi-login';
  static String verifyOtpUrl = '$appUrl/tulsi-validate-otp';

  static String getMenuItemsUrl = '$appUrl/items';
  static String addToCartSingleItem = '$appUrl/store-item';
  static String updateCartSingleItem = '$appUrl/update-quantity';
  static String getDashboard = '$appUrl/check-condition';
  static String getAddresses = '$appUrl/addresses';
  static String storeAddress = '$appUrl/store-address';
  static String deleteAddress = '$appUrl/delete-address';
  static String getProducts = '$appUrl/products';
  static String storeProduct = '$appUrl/store-product';
  static String checkout = '$appUrl/checkout';
  static String placeOrder = '$appUrl/place-order';
  static String defaultAddress = '$appUrl/default-address';
  static String getProfileInfo = '$appUrl/get-profile-info';
  static String storeProfileInfo = '$appUrl/store-profile-info';
  static String logout = '$appUrl/logout';
  static String getOrders = '$appUrl/orders';
  static String deleteAccount = '$appUrl/delete-account';

  static const ApiMethod method = ApiMethod();
}

class ApiMethod {
  const ApiMethod(); //
  final String get = "GET";
  final String post = "POST";
  final String put = "PUT";
  final String delete = "DELETE";
}
