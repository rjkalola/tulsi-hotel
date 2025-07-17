import 'dart:convert';

import 'package:dio/dio.dart' as multi;
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/dashboard/controller/dashboard_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/model/dashboard_response.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/home_tab/controller/home_tab_repository.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/web_services/api_constants.dart';
import 'package:tulsi_hotel/web_services/response/response_model.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../../utils/app_constants.dart';

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
    dashboardResponseApi(true);
  }

  void dashboardResponseApi(bool isProgress) async {
    Map<String, dynamic> map = {};
    map["language"] = 2;
    multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = isProgress;
    _api.dashboardResponse(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        DashboardResponse response =
            DashboardResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          isMainViewVisible.value = true;
          dashboardData.value = response;
          dashboardController.cartCount.value = response.data?.cartCount ?? 0;
          dashboardController.address.value = response.data?.address ?? "";
          dashboardController.addressVisible.value = true;
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

  moveToProducts(int productType, int dayType) async {
    var arguments = {
      AppConstants.intentKey.productType: productType,
      AppConstants.intentKey.dayType: dayType,
    };
    var result =
        await Get.toNamed(AppRoutes.productListScreen, arguments: arguments);
    if (result != null && result) {
      dashboardResponseApi(false);
    }
  }
}
