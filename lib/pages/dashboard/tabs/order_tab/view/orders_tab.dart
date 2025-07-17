import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/controller/menu_tab_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/view/widgets/menu_list.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/order_tab/controller/order_tab_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/order_tab/view/widgets/order_list.dart';
import 'package:tulsi_hotel/widgets/custom_views/no_internet_widgets.dart';
import 'package:tulsi_hotel/widgets/progressbar/CustomProgressbar.dart';

import '../../../../../res/colors.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  int selectedActionButtonPagerPosition = 0;
  final controller = Get.put(OrderTabController());

  @override
  void initState() {
    // showProgress();
    // setHeaderActionButtons();
    // userInfo = Get.find<AppStorage>().getUserInfo();
    super.initState();
  }

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
                  controller.getOrdersApi(true,true);
                },
              )
            : ModalProgressHUD(
                inAsyncCall: controller.isLoading.value,
                opacity: 0,
                progressIndicator: const CustomProgressbar(),
                child: Column(
                  children: [
                    OrderList(orderList: controller.orderList),
                    Visibility(
                      visible: controller.isLoadMore.value,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 14),
                        child: Row(
                          children: [
                            const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator()),
                            const SizedBox(
                              width: 14,
                            ),
                            Text(
                              'loading_more_'.tr,
                              style: const TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
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

}
