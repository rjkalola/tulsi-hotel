import 'dart:convert';

import 'package:dio/dio.dart' as multi;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/authentication/login/view/login_screen.dart';
import 'package:tulsi_hotel/pages/common/model/user_info.dart';
import 'package:tulsi_hotel/pages/common/model/user_response.dart';
import 'package:tulsi_hotel/pages/dashboard/controller/dashboard_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/home_tab/controller/home_tab_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/profile_tab/controller/profile_tab_repository.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/profile_tab/view/edit_profile_dialog.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/profile_tab/view/update_profile_data_listener.dart';
import 'package:tulsi_hotel/routes/app_routes.dart';
import 'package:tulsi_hotel/utils/app_storage.dart';
import 'package:tulsi_hotel/utils/string_helper.dart';
import 'package:tulsi_hotel/web_services/response/base_response.dart';
import 'package:tulsi_hotel/web_services/response/response_model.dart';

import '../../../../../utils/app_utils.dart';
import '../../../../../web_services/api_constants.dart';

class ProfileTabController extends GetxController
    with GetSingleTickerProviderStateMixin
    implements UpdateProfileDataListener {
  final _api = ProfileTabRepository();

  RxBool isLoading = false.obs,
      isInternetNotAvailable = false.obs,
      isMainViewVisible = false.obs;
  final userInfo = UserInfo().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    getProfileInfoApi(true);
  }

  void getProfileInfoApi(bool isProgress) async {
    Map<String, dynamic> map = {};
    map["language"] = 2;
    // multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = isProgress;
    _api.getProfileInfo(
      data: map,
      onSuccess: (ResponseModel responseModel) {
        UserResponse response =
            UserResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          isMainViewVisible.value = true;
          userInfo.value = response.data!;
        } else {
          // AppUtils.showSnackBarMessage(responseModel.statusMessage!);
        }
        isLoading.value = false;
      },
      onError: (ResponseModel error) {
        isLoading.value = false;
        if (error.statusCode == ApiConstants.CODE_NO_INTERNET_CONNECTION) {
          isInternetNotAvailable.value = true;
        }
      },
    );
  }

  void storeProfileInfo(UserInfo info) async {
    Map<String, dynamic> map = {};
    map["name"] = info.name ?? "";
    map["email"] = info.email ?? "";
    multi.FormData formData = multi.FormData.fromMap(map);
    if (!StringHelper.isEmptyString(info.image) &&
        !(info.image ?? "").startsWith("http")) {
      formData.files.add(
        MapEntry("image", await multi.MultipartFile.fromFile(info.image ?? "")),
      );
    }
    isLoading.value = true;
    _api.storeProfileInfo(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        if (responseModel.isSuccess) {
          UserResponse response =
              UserResponse.fromJson(jsonDecode(responseModel.result!));
          // userInfo.value = response.data!;
          userInfo.value.name = response.data!.name ?? "";
          userInfo.value.email = response.data!.email ?? "";
          userInfo.value.image = response.data!.image ?? "";
          userInfo.refresh();
          AppUtils.showApiResponseMessage(response.message ?? "");
        } else {
          AppUtils.showApiResponseMessage(responseModel.statusMessage ?? "");
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

  void logoutApi(bool isProgress) async {
    Map<String, dynamic> map = {};
    isLoading.value = isProgress;
    _api.logout(
      data: map,
      onSuccess: (ResponseModel responseModel) {
        BaseResponse response =
            BaseResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          Get.find<AppStorage>().clearAllData();
          Get.offAllNamed(AppRoutes.loginScreen);
        } else {
          // AppUtils.showSnackBarMessage(responseModel.statusMessage!);
        }
        isLoading.value = false;
      },
      onError: (ResponseModel error) {
        isLoading.value = false;
        if (error.statusCode == ApiConstants.CODE_NO_INTERNET_CONNECTION) {
          isInternetNotAvailable.value = true;
        }
      },
    );
  }

  void showEditProfileDialog() {
    Get.bottomSheet(
        EditProfileDialog(
          info: userInfo.value,
          listener: this,
        ),
        backgroundColor: Colors.transparent,
        isScrollControlled: true);
  }

  @override
  void onUpdateProfileData(UserInfo info) {
    storeProfileInfo(info);
    print("name:" + (info.name ?? ""));
    print("email:" + (info.email ?? ""));
    print("image:" + (info.image ?? ""));
  }

  moveToAddress() async {
    var result = await Get.toNamed(AppRoutes.addressListScreen);
    getProfileInfoApi(false);
    Get.put(HomeTabController()).dashboardResponseApi(false);
  }
}
