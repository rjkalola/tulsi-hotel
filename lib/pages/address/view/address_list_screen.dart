import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tulsi_hotel/pages/address/controller/address_list_controller.dart';
import 'package:tulsi_hotel/pages/address/model/adress_info.dart';
import 'package:tulsi_hotel/pages/address/view/widgets/address_list.dart';
import 'package:tulsi_hotel/pages/address/view/widgets/address_toolbar_widget.dart';
import 'package:tulsi_hotel/pages/address/view/widgets/empty_address_view.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/widgets/buttons/PrimaryBorderButton.dart';
import 'package:tulsi_hotel/widgets/custom_views/no_internet_widgets.dart';
import 'package:tulsi_hotel/widgets/progressbar/CustomProgressbar.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<AddressListScreen> {
  final controller = Get.put(AddressListController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: backgroundColor,
        statusBarIconBrightness: Brightness.dark));
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Obx(() {
            return ModalProgressHUD(
                inAsyncCall: controller.isLoading.value,
                opacity: 0,
                progressIndicator: const CustomProgressbar(),
                child: controller.isInternetNotAvailable.value
                    ? NoInternetWidget(
                        onPressed: () {
                          controller.isInternetNotAvailable.value = false;
                          controller.addressListResponseApi();
                        },
                      )
                    : Visibility(
                        visible: controller.isMainViewVisible.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AddressToolbarWidget(),
                            SizedBox(
                              height: 12,
                            ),
                            controller.addressList.isNotEmpty
                                ? AddressList()
                                : EmptyAddressView(),
                            controller.addressList.isNotEmpty
                                ? PrimaryBorderButton(
                                    margin: EdgeInsets.all(16),
                                    buttonText: 'add_new_address'.tr,
                                    onPressed: () {
                                      controller.showSelectShiftDialog(AddressInfo());
                                    })
                                : Container()
                          ],
                        ),
                      ));
          }),
        ),
      ),
    );
  }
}
