import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart' as multi;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tulsi_hotel/pages/authentication/login/controller/login_repository.dart';
import 'package:tulsi_hotel/pages/common/listener/SelectPhoneExtensionListener.dart';
import 'package:tulsi_hotel/pages/common/model/user_response.dart';
import 'package:tulsi_hotel/routes/app_routes.dart';
import 'package:tulsi_hotel/utils/app_constants.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/web_services/api_constants.dart';
import 'package:tulsi_hotel/web_services/response/response_model.dart';

class LoginController extends GetxController
    implements SelectPhoneExtensionListener {
  final phoneController = TextEditingController().obs;
  final formKey = GlobalKey<FormState>();

  final _api = LoginRepository();

  RxBool isLoading = false.obs,
      isInternetNotAvailable = false.obs,
      isOtpViewVisible = false.obs;
  final otpController = TextEditingController().obs;
  final mOtpCode = "".obs;
  final otmResendTimeRemaining = 30.obs;
  Timer? _timer;

  listenSmsCode() async {
    print("regiestered");
    await SmsAutoFill().listenForCode();
  }

  @override
  void onInit() {
    super.onInit();
    // getRegisterResources();
  }

  void login() async {
    Map<String, dynamic> map = {};
    map["phone_number"] = phoneController.value.text;
    map["device_type"] = AppConstants.deviceType;
    multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = true;
    _api.login(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        UserResponse response =
            UserResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          var arguments = {
            AppConstants.intentKey.id: response.data?.id ?? 0,
            AppConstants.intentKey.phoneNumber:
                response.data?.phoneNumber ?? "",
          };
          Get.toNamed(AppRoutes.otpVerificationScreen, arguments: arguments);
        } else {
          AppUtils.showApiResponseMessage(response.message ?? "");
        }
        isLoading.value = false;
      },
      onError: (ResponseModel error) {
        isLoading.value = false;
        if (error.statusCode == ApiConstants.CODE_NO_INTERNET_CONNECTION) {
          AppUtils.showApiResponseMessage('no_internet'.tr);
        } else if (error.statusMessage!.isNotEmpty) {
          AppUtils.showApiResponseMessage(error.statusMessage);
        }
      },
    );
  }

  bool valid() {
    return formKey.currentState!.validate();
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
