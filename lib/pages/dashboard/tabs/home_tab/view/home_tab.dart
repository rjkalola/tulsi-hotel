import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/home_tab/controller/home_tab_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/home_tab/view/widgets/dashboard_item_box.dart';
import 'package:tulsi_hotel/widgets/custom_views/no_internet_widgets.dart';
import 'package:tulsi_hotel/widgets/progressbar/CustomProgressbar.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextView.dart';

import '../../../../../res/colors.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  int selectedActionButtonPagerPosition = 0;
  final controller = Get.put(HomeTabController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: backgroundColor,
        // backgroundColor: const Color(0xfff4f5f7),
        body: controller.isInternetNotAvailable.value
            ? NoInternetWidget(
                onPressed: () {
                  controller.isInternetNotAvailable.value = false;
                  controller.dashboardResponseApi();
                },
              )
            : ModalProgressHUD(
                inAsyncCall: controller.isLoading.value,
                opacity: 0,
                progressIndicator: const CustomProgressbar(),
                child: Visibility(
                  visible: controller.isMainViewVisible.value,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: (controller.dashboardData.value.data
                                            ?.showTodayLunch ??
                                        0) ==
                                    1 ||
                                (controller.dashboardData.value.data
                                            ?.showTodayDinner ??
                                        0) ==
                                    1,
                            child: SizedBox(
                              height: 20,
                            ),
                          ),
                          Visibility(
                            visible: (controller.dashboardData.value.data
                                            ?.showTodayLunch ??
                                        0) ==
                                    1 ||
                                (controller.dashboardData.value.data
                                            ?.showTodayDinner ??
                                        0) ==
                                    1,
                            child: PrimaryTextView(
                              'for_today'.tr,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                          DashboardItemBox(
                            visible: (controller.dashboardData.value.data
                                        ?.showTodayLunch ??
                                    0) ==
                                1,
                            title: 'order_a_lunch'.tr,
                            time: 'lunch_time'.tr,
                            productType: 1,
                            dayType: 1,
                          ),
                          DashboardItemBox(
                            visible: (controller.dashboardData.value.data
                                        ?.showTodayDinner ??
                                    0) ==
                                1,
                            title: 'order_a_dinner'.tr,
                            time: 'dinner_time'.tr,
                            productType: 2,
                            dayType: 1,
                          ),
                          Visibility(
                            visible: (controller.dashboardData.value.data
                                            ?.tomorrowTodayLunch ??
                                        0) ==
                                    1 ||
                                (controller.dashboardData.value.data
                                            ?.tomorrowTodayDinner ??
                                        0) ==
                                    1,
                            child: SizedBox(
                              height: 20,
                            ),
                          ),
                          Visibility(
                            visible: (controller.dashboardData.value.data
                                            ?.tomorrowTodayLunch ??
                                        0) ==
                                    1 ||
                                (controller.dashboardData.value.data
                                            ?.tomorrowTodayDinner ??
                                        0) ==
                                    1,
                            child: PrimaryTextView(
                              'for_tomorrow'.tr,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                          DashboardItemBox(
                            visible: (controller.dashboardData.value.data
                                        ?.tomorrowTodayLunch ??
                                    0) ==
                                1,
                            title: 'order_a_lunch'.tr,
                            time: 'lunch_time'.tr,
                            productType: 1,
                            dayType: 2,
                          ),
                          DashboardItemBox(
                            visible: (controller.dashboardData.value.data
                                        ?.tomorrowTodayDinner ??
                                    0) ==
                                1,
                            title: 'order_a_dinner'.tr,
                            time: 'dinner_time'.tr,
                            productType: 2,
                            dayType: 2,
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

        /* body: Visibility(
          visible: controller.isMainViewVisible.value,
          child: Column(children: [
            HeaderUserDetailsView(),
            SizedBox(
              height: 12,
            ),
            DashboardGridView()
          ]),
        ),*/
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }
}
