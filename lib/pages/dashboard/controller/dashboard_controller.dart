import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/dashboard/controller/dashboard_repository.dart';
import 'package:tulsi_hotel/pages/dashboard/model/dashboard_response.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/empty_tab.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/home_tab/controller/home_tab_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/home_tab/controller/home_tab_repository.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/home_tab/view/home_tab.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/view/menu_tab.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/order_tab/view/orders_tab.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/profile_tab/view/profile_tab.dart';
import 'package:dio/dio.dart' as multi;
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/web_services/api_constants.dart';
import 'package:tulsi_hotel/web_services/response/response_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/app_constants.dart';

class DashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _api = DashboardRepository();

  RxBool isLoading = false.obs,
      isInternetNotAvailable = false.obs,
      isMainViewVisible = false.obs,
      addressVisible = false.obs;
  RxInt cartCount = 0.obs;
  final title = 'dashboard'.tr.obs, address = "".obs;
  final selectedIndex = 0.obs;
  final searchController = TextEditingController().obs;

  // final pageController = PageController();
  late final PageController pageController;
  final tabs = <Widget>[
    // StockListScreen(),
    HomeTab(),
    MenuTab(),
    OrdersTab(),
    ProfileTab(),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    var arguments = Get.arguments;
    if (arguments != null) {
      selectedIndex.value = arguments[AppConstants.intentKey.dashboardTabIndex];
    }
    pageController = PageController(initialPage: selectedIndex.value);
    setTitle(selectedIndex.value);

    dashboardResponseApi(false);
    // getSettingApi();
  }

  @override
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int index) {
    selectedIndex.value = index;
    print("selectedIndex.value:${selectedIndex.value}");
    setTitle(index);
  }

  void setTitle(int index) {
    if (index == 0) {
      title.value = 'dashboard'.tr;
    }
    // else if (index == 1) {
    //   title.value = 'profile'.tr;
    // }
    else if (index == 1) {
      title.value = 'more'.tr;
    }
  }

  void onItemTapped(int index) {
    // if (index == 1) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => ScannerScreen()),
    //   );
    // } else {
    pageController.jumpToPage(index);

    // }
  }

  //Home Tab
  final selectedActionButtonPagerPosition = 0.obs;
  final dashboardActionButtonsController = PageController(
    initialPage: 0,
  );

  void onActionButtonClick(String action) {
    /* if (action == AppConstants.action.items) {
      Get.offNamed(AppRoutes.productListScreen);
    } else if (action == AppConstants.action.store) {
      Get.offNamed(AppRoutes.storeListScreen);
    } else if (action == AppConstants.action.stocks) {
      Get.offNamed(AppRoutes.stockListScreen);
    } else if (action == AppConstants.action.suppliers) {
      Get.offNamed(AppRoutes.supplierListScreen);
    } else if (action == AppConstants.action.categories) {
      Get.offNamed(AppRoutes.categoryListScreen);
    }*/
  }

  void dashboardResponseApi(bool isProgress) async {
    Map<String, dynamic> map = {};
    map["language"] = 2;
    multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = isProgress;
    HomeTabRepository().dashboardResponse(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        DashboardResponse response =
            DashboardResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          isMainViewVisible.value = true;
          cartCount.value = response.data?.cartCount ?? 0;
          address.value = response.data?.address ?? "";
          addressVisible.value = true;
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

  moveToAddress() async {
    var result = await Get.toNamed(AppRoutes.addressListScreen);
    Get.put(HomeTabController()).dashboardResponseApi(false);
  }

  Future<void> moveToCart() async {
    var result = await Get.toNamed(AppRoutes.cartListScreen);
    Get.put(HomeTabController()).dashboardResponseApi(false);
  }
}
