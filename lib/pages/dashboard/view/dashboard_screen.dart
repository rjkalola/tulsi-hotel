import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tulsi_hotel/pages/dashboard/controller/dashboard_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/view/bottom_navigation_bar_widget.dart';
import 'package:tulsi_hotel/pages/dashboard/view/widgets/dashboard_toolbar_widget.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/widgets/progressbar/CustomProgressbar.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextView.dart';
import 'package:tulsi_hotel/widgets/textfield/search_text_field.dart';

import '../../../utils/app_utils.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});

  final controller = Get.put(DashboardController());
  DateTime? currentBackPressTime;
  var mTime;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: backgroundColor,
        statusBarIconBrightness: Brightness.dark));
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        final backNavigationAllowed = await onBackPress();
        if (backNavigationAllowed) {
          Get.delete<DashboardController>();
          if (Platform.isIOS) {
            exit(0);
          } else {
            SystemNavigator.pop();
          }
        }
      },
      child: Container(
        color: backgroundColor,
        child: SafeArea(
            child: Obx(() => ModalProgressHUD(
                inAsyncCall: controller.isLoading.value,
                opacity: 0,
                progressIndicator: const CustomProgressbar(),
                child: Scaffold(
                  backgroundColor: backgroundColor,
                  // appBar: dashboardController.selectedIndex.value == 0
                  //     ? null
                  //     : BaseAppBar(
                  //         appBar: AppBar(),
                  //         title: dashboardController.title.value,
                  //         isCenterTitle: false,
                  //         isBack: true,
                  //         widgets: actionButtons(),
                  //       ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DashboardToolbarWidget(),
                      Visibility(
                        visible: controller.selectedIndex.value != 3,
                        child: SearchTextField(
                            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                            controller: controller.searchController,
                            hint: 'search_for_tiffins_thali_dishes'.tr,
                            label: 'search_for_tiffins_thali_dishes'.tr,
                            isClearVisible: false.obs),
                      ),
                      Expanded(
                          child: PageView(
                        controller: controller.pageController,
                        onPageChanged: controller.onPageChanged,
                        physics: const NeverScrollableScrollPhysics(),
                        children: controller.tabs,
                      )),
                      Divider(
                        height: 0,
                        color: dividerColor,
                      )
                    ],
                  ),
                  bottomNavigationBar: BottomNavigationBarWidget(),
                )))),
      ),
    );
  }

  List<Widget>? actionButtons() {
    return [
      // Visibility(
      //   visible: (dashboardController.selectedIndex.value == 0 &&
      //       !Get.put(StockListController()).isScanQrCode.value),
      //   child: InkWell(
      //       onTap: () {
      //         dashboardController.addMultipleStockQuantity();
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.only(right: 14),
      //         child: Text(
      //           "+${'add_stock'.tr}",
      //           style: const TextStyle(
      //               fontSize: 16,
      //               color: defaultAccentColor,
      //               fontWeight: FontWeight.w500),
      //         ),
      //       )),
      // ),
      // Visibility(
      //   visible: (dashboardController.selectedIndex.value == 0 &&
      //       Get.put(StockListController()).isScanQrCode.value),
      //   child: InkWell(
      //       onTap: () {
      //         Get.put(StockListController())
      //             .getStockListApi(true, false, "", true, true);
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.only(right: 14),
      //         child: Text(
      //           'clear'.tr,
      //           style: const TextStyle(
      //               fontSize: 16,
      //               color: Colors.red,
      //               fontWeight: FontWeight.w500),
      //         ),
      //       )),
      // ),
    ];
  }

  Future<bool> onBackPress() {
    DateTime now = DateTime.now();
    if (mTime == null || now.difference(mTime) > const Duration(seconds: 2)) {
      mTime = now;
      AppUtils.showToastMessage('exit_warning'.tr);
      return Future.value(false);
    }

    return Future.value(true);
  }
}
