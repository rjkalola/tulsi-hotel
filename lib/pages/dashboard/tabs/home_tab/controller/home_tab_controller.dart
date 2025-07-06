import 'dart:convert';

import 'package:dio/dio.dart' as multi;
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/dashboard/controller/dashboard_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/model/dashboard_response.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/home_tab/controller/home_tab_repository.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/web_services/api_constants.dart';
import 'package:tulsi_hotel/web_services/response/response_model.dart';

class HomeTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _api = HomeTabRepository();

  RxBool isLoading = false.obs,
      isInternetNotAvailable = false.obs,
      isMainViewVisible = false.obs;
  final dashboardController = Get.put(DashboardController());
  final dashboardData = DashboardResponse().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    dashboardResponseApi();
  }

  void dashboardResponseApi() async {
    Map<String, dynamic> map = {};
    map["language"] = 2;
    multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = true;
    _api.dashboardResponse(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        DashboardResponse response =
            DashboardResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          isMainViewVisible.value = true;
          dashboardData.value = response;
          dashboardController.cartCount.value = response.data?.cartCount ?? 0;
        } else {
          // AppUtils.showSnackBarMessage(responseModel.statusMessage!);
        }
        isLoading.value = false;
      },
      onError: (ResponseModel error) {
        isLoading.value = false;
        if (error.statusCode == ApiConstants.CODE_NO_INTERNET_CONNECTION) {
          AppUtils.showSnackBarMessage('no_internet'.tr);
        }
      },
    );
  }
}
