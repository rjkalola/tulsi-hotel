import 'dart:async';

import 'package:get/get.dart';
import 'package:tulsi_hotel/routes/app_routes.dart';
import 'package:tulsi_hotel/utils/app_storage.dart';
import 'package:tulsi_hotel/web_services/api_constants.dart';

class SplashServices {
  Future<void> isLogin() async {
    Timer(const Duration(seconds: 2), () async {
      ApiConstants.accessToken = Get.find<AppStorage>().getAccessToken();
      print(ApiConstants.accessToken??"");

      if (ApiConstants.accessToken.isNotEmpty) {
        Get.offAllNamed(AppRoutes.dashboardScreen);
      } else {
        Get.offAllNamed(AppRoutes.loginScreen);
      }
    });
    // String? appSignature = await SmsAutoFill().getAppSignature;
    // AppUtils.showApiResponseMessage(appSignature);
    // print("App Signature: ${appSignature??""}");
  }
}
