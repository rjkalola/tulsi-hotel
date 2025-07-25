import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/address/view/address_list_screen.dart';
import 'package:tulsi_hotel/pages/address_location/view/address_location_screen.dart';
import 'package:tulsi_hotel/pages/authentication/login/view/login_screen.dart';
import 'package:tulsi_hotel/pages/authentication/otp_verification/view/otp_verification_screen.dart';
import 'package:tulsi_hotel/pages/authentication/splash/splash_screen.dart';
import 'package:tulsi_hotel/pages/cart/view/cart_list_screen.dart';
import 'package:tulsi_hotel/pages/dashboard/view/dashboard_screen.dart';
import 'package:tulsi_hotel/pages/product_list/view/product_list_screen.dart';

import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.otpVerificationScreen,
      page: () => OtpVerificationScreen(),
    ),
    GetPage(
      name: AppRoutes.dashboardScreen,
      page: () => DashBoardScreen(),
    ),
    GetPage(
      name: AppRoutes.addressListScreen,
      page: () => AddressListScreen(),
    ),
    GetPage(
      name: AppRoutes.addressLocationScreen,
      page: () => AddressLocationScreen(),
    ),
    GetPage(
      name: AppRoutes.productListScreen,
      page: () => ProductListScreen(),
    ),
    GetPage(
      name: AppRoutes.cartListScreen,
      page: () => CartListScreen(),
    ),
  ];
}
