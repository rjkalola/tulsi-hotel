import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/controller/menu_tab_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/view/widgets/menu_list.dart';
import 'package:tulsi_hotel/widgets/custom_views/no_internet_widgets.dart';
import 'package:tulsi_hotel/widgets/progressbar/CustomProgressbar.dart';

import '../../../../../res/colors.dart';

class MenuTab extends StatefulWidget {
  const MenuTab({super.key});

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> with AutomaticKeepAliveClientMixin {
  int selectedActionButtonPagerPosition = 0;
  final controller = Get.put(MenuTabController());

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
                  controller.getMenuItemsApi(true);
                },
              )
            : ModalProgressHUD(
                inAsyncCall: controller.isLoading.value,
                opacity: 0,
                progressIndicator: const CustomProgressbar(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 14),
                  child: MenuList(),
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
