// views/location_search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tulsi_hotel/pages/address/model/adress_info.dart';
import 'package:tulsi_hotel/pages/product_list/controller/product_list_controller.dart';
import 'package:tulsi_hotel/pages/product_list/view/widgets/product_list.dart';
import 'package:tulsi_hotel/pages/product_list/view/widgets/product_list_toolbar_widget.dart';
import 'package:tulsi_hotel/pages/product_list/view/widgets/tab_bar_widget.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/utils/string_helper.dart';
import 'package:tulsi_hotel/widgets/progressbar/CustomProgressbar.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextViewInter.dart';

class ProductListScreen extends StatelessWidget {
  final controller = Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: backgroundColor,
        statusBarIconBrightness: Brightness.dark));
    return Obx(
      () => DefaultTabController(
        length: 2,
        initialIndex: controller.currentIndex.value,
        child: Container(
          color: backgroundColor,
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
              child: Scaffold(
            body: ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              opacity: 0,
              progressIndicator: const CustomProgressbar(),
              child: Column(
                children: [
                  ProductListToolbarWidget(),
                  TabBarWidget(),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 18),
                      color: backgroundColor,
                      child: Visibility(
                          visible: controller.isMainViewVisible.value,
                          child: controller.productList.isNotEmpty
                              ? ProductList(
                                  productList: controller.productList,
                                  isLoading: controller.isLoading)
                              : Center(
                                  child: PrimaryTextViewInter(
                                      'no_data_found'.tr))),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }

  String getAddressText(AddressInfo info) {
    String address = "";
    address = info.flatNumber ?? "";
    address += !StringHelper.isEmptyString(info.apartment)
        ? ", ${info.apartment}"
        : "";
    address += !StringHelper.isEmptyString(info.area) ? ", ${info.area}" : "";
    address += info.pincode != 0 ? " - ${info.pincode}" : "";
    return address;
  }
}
