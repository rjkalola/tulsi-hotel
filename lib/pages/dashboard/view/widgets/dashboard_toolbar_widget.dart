import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/dashboard/controller/dashboard_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/view/widgets/add_your_address_here.dart';
import 'package:tulsi_hotel/pages/dashboard/view/widgets/address_details.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/utils/string_helper.dart';
import 'package:tulsi_hotel/widgets/shapes/badge_count_widget.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextViewInter.dart';

class DashboardToolbarWidget extends StatelessWidget {
  DashboardToolbarWidget({super.key});

  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
        child: Row(children: [
          Visibility(
            visible: controller.selectedIndex.value == 0 ||
                controller.selectedIndex.value == 1,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Get.back(),
              child: Container(
                width: 34,
                height: 34,
                padding: EdgeInsets.all(7),
                decoration: AppUtils.getGrayBorderDecoration(
                    color: Color(0xFFFFF5E6), radius: 4),
                child: SvgPicture.asset(
                  Drawable.address,
                  width: 16,
                  height: 16,
                ),
              ),
            ),
          ),
          Visibility(
            visible: controller.selectedIndex.value == 0 ||
                controller.selectedIndex.value == 1,
            child: SizedBox(
              width: 10,
            ),
          ),
          Visibility(
            visible: controller.addressVisible.value &&
                (controller.selectedIndex.value == 0 ||
                    controller.selectedIndex.value == 1),
            child: Expanded(
                child: !StringHelper.isEmptyString(controller.address.value)
                    ? AddressDetails()
                    : AddYourAddressHere()),
          ),
          Visibility(
              visible: controller.selectedIndex.value == 0 ||
                  controller.selectedIndex.value == 1,
              child: SizedBox(width: 12)),
          Visibility(
            visible: controller.selectedIndex.value == 2 ||
                controller.selectedIndex.value == 3,
            child: Expanded(
                child: PrimaryTextViewInter(
              controller.selectedIndex.value == 3
                  ? 'edit_profile'.tr
                  : 'orders'.tr,
              color: primaryTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            )),
          ),
          Visibility(
            visible: controller.isMainViewVisible.value,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => controller.moveToCart(),
              child: Container(
                width: 34,
                height: 34,
                decoration: AppUtils.getGrayBorderDecoration(
                    color: Color(0xFFFFF5E6), radius: 4),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      Drawable.cart,
                      width: 16,
                      height: 16,
                    ),
                    Visibility(
                      visible: controller.cartCount.value > 0,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CustomBadgeIcon(
                          count: controller.cartCount.value,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
