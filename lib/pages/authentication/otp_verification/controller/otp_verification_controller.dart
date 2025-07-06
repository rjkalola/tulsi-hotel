import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart' as multi;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tulsi_hotel/pages/authentication/otp_verification/controller/otp_verification_repository.dart';
import 'package:tulsi_hotel/pages/common/model/user_response.dart';
import 'package:tulsi_hotel/routes/app_routes.dart';
import 'package:tulsi_hotel/utils/app_constants.dart';
import 'package:tulsi_hotel/utils/app_storage.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/web_services/api_constants.dart';
import 'package:tulsi_hotel/web_services/response/response_model.dart';

class OtpVerificationController extends GetxController {
  final phoneController = TextEditingController().obs;
  final formKey = GlobalKey<FormState>();

  final _api = OtpVerificationRepository();

  RxBool isLoading = false.obs,
      isInternetNotAvailable = false.obs,
      isMainViewVisible = true.obs;
  final otpController = TextEditingController().obs;
  final mOtpCode = "".obs;
  final otmResendTimeRemaining = 30.obs;
  Timer? _timer;
  int userId = 0;
  String phoneNumber = "";

  listenSmsCode() async {
    print("regiestered");
    await SmsAutoFill().listenForCode();
  }

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments;
    if (arguments != null) {
      userId = arguments[AppConstants.intentKey.id] ?? 0;
      phoneNumber = arguments[AppConstants.intentKey.phoneNumber] ?? "";
    }
  }

  void verifyOtpApi() async {
    Map<String, dynamic> map = {};
    map["user_id"] = userId;
    map["otp"] = mOtpCode;
    multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = true;
    _api.verifyOtp(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        UserResponse response =
            UserResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          Get.find<AppStorage>().setUserInfo(response.data!);
          Get.find<AppStorage>().setAccessToken(response.data!.apiToken ?? "");
          ApiConstants.accessToken = response.data!.apiToken ?? "";
          Get.offAllNamed(AppRoutes.dashboardScreen);
        } else {
          AppUtils.showApiResponseMessage(response.message ?? "");
        }
        isLoading.value = false;
      },
      onError: (ResponseModel error) {
        isLoading.value = false;
        if (error.statusCode == ApiConstants.CODE_NO_INTERNET_CONNECTION) {
          AppUtils.showApiResponseMessage('no_internet'.tr);
        }
      },
    );
  }

  bool valid(bool isAutoLogin) {
    if (!isAutoLogin) {
      return formKey.currentState!.validate();
    } else {
      return true;
    }
  }

  @override
  void onSelectPhoneExtension(
      int id, String extension, String flag, String country) {}

  void startOtpTimeCounter() {
    otmResendTimeRemaining.value = 30;
    stopOtpTimeCounter(); // Cancel previous timer if exists
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (otmResendTimeRemaining.value == 0) {
        timer.cancel();
      } else {
        otmResendTimeRemaining.value--;
      }
    });
  }

  void stopOtpTimeCounter() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    stopOtpTimeCounter(); // Clean up
    SmsAutoFill().unregisterListener();
    super.dispose();
  }
}
