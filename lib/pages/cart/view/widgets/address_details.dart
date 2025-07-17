import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/cart/controller/cart_list_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/controller/dashboard_controller.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/routes/app_routes.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextViewInter.dart';

class AddressDetails extends StatelessWidget {
  AddressDetails({super.key});

  final controller = Get.put(CartListController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.moveToAddress();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PrimaryTextViewInter(
                'your_address'.tr,
                color: secondaryTextColor,
                fontSize: 13,
              ),
              Icon(
                Icons.arrow_drop_down_outlined,
                size: 20,
              )
            ],
          ),
          PrimaryTextViewInter(
            controller.address.value ?? "",
            maxLine: 1,
            overflow: TextOverflow.ellipsis,
            color: primaryTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}
