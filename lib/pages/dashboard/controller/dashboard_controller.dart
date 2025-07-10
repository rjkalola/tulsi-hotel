import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/dashboard/controller/dashboard_repository.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/empty_tab.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/home_tab/view/home_tab.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/view/menu_tab.dart';

class DashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _api = DashboardRepository();

  RxBool isLoading = false.obs,
      isInternetNotAvailable = false.obs,
      isMainViewVisible = false.obs,addressVisible = false.obs;
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
    EmptyTab(),
    EmptyTab(),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    var arguments = Get.arguments;
    if (arguments != null) {
      // selectedIndex.value = arguments[AppConstants.intentKey.dashboardTabIndex];
    }
    pageController = PageController(initialPage: selectedIndex.value);
    setTitle(selectedIndex.value);

    // dashboardResponseApi();
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

/* void logoutAPI() async {
    String deviceModelName = await AppUtils.getDeviceName();
    Map<String, dynamic> map = {};
    map["model_name"] = deviceModelName;
    // map["is_inventory"] = "true";
    multi.FormData formData = multi.FormData.fromMap(map);
    print("request parameter:" + map.toString());
    isLoading.value = true;
    _api.logout(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        if (responseModel.statusCode == 200) {
          Get.find<AppStorage>().clearAllData();
          Get.offAllNamed(AppRoutes.loginScreen);
        } else {
          AppUtils.showSnackBarMessage(responseModel.statusMessage!);
        }
        isLoading.value = false;
      },
      onError: (ResponseModel error) {
        isLoading.value = false;
        if (error.statusCode == ApiConstants.CODE_NO_INTERNET_CONNECTION) {
          AppUtils.showSnackBarMessage('no_internet'.tr);
        } else if (error.statusMessage!.isNotEmpty) {
          AppUtils.showSnackBarMessage(error.statusMessage!);
        }
      },
    );
  }*/
}
