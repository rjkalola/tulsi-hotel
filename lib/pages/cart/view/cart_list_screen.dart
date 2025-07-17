// views/location_search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tulsi_hotel/pages/cart/controller/cart_list_controller.dart';
import 'package:tulsi_hotel/pages/cart/view/widgets/add_your_comments.dart';
import 'package:tulsi_hotel/pages/cart/view/widgets/bill_summery_details.dart';
import 'package:tulsi_hotel/pages/cart/view/widgets/cart_list.dart';
import 'package:tulsi_hotel/pages/cart/view/widgets/cart_list_toolbar.dart';
import 'package:tulsi_hotel/pages/cart/view/widgets/delivery_time_note.dart';
import 'package:tulsi_hotel/pages/cart/view/widgets/empty_cart_view.dart';
import 'package:tulsi_hotel/pages/cart/view/widgets/pay_button.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/widgets/progressbar/CustomProgressbar.dart';

class CartListScreen extends StatelessWidget {
  final controller = Get.put(CartListController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: backgroundColor,
        statusBarIconBrightness: Brightness.dark));
    return Container(
      color: backgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: SafeArea(
          child: Scaffold(
        body: Obx(
          () => ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            opacity: 0,
            progressIndicator: const CustomProgressbar(),
            child: Container(
              color: backgroundColor,
              child: Column(
                children: [
                  CartListToolbar(),
                  SizedBox(
                    height: 14,
                  ),
                  Visibility(
                    visible: controller.isMainViewVisible.value,
                    child: Expanded(
                      child: Column(
                        children: [
                          controller.cartList.isNotEmpty
                              ? Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        CartList(cartList: controller.cartList),
                                        AddYourComments(
                                            controller:
                                                controller.commentController),
                                        BillSummeryDetails(
                                          totalAmount: controller
                                              .totalAmount.value
                                              .toString(),
                                          taxAmount: controller.taxAmount.value
                                              .toString(),
                                          deliveryCharge: controller
                                              .deliveryCharge.value
                                              .toString(),
                                          totalToPay: controller
                                              .totalToPay.value
                                              .toString(),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : EmptyCartView(),
                          SizedBox(
                            height: 14,
                          ),
                          DeliveryTimeNote(),
                          PayButton(
                            totalToPay: controller.totalToPay.value.toString(),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
