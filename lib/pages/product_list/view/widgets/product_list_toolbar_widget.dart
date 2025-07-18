import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/address/controller/address_list_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/view/widgets/add_your_address_here.dart';
import 'package:tulsi_hotel/pages/product_list/controller/product_list_controller.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/widgets/shapes/badge_count_widget.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextViewInter.dart';

class ProductListToolbarWidget extends StatelessWidget {
  ProductListToolbarWidget({super.key});

  final controller = Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
      color: backgroundColor,
      child: Stack(alignment: Alignment.center, children: [
        Align(
          alignment: Alignment.centerLeft,
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
                Drawable.arrowLeftAltIcon,
                width: 16,
                height: 16,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        PrimaryTextViewInter(
          ''.tr,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        Align(
          alignment: Alignment.centerRight,
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
                  Obx(() => Visibility(
                    visible: controller.cartCount.value > 0,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CustomBadgeIcon(
                        count: controller.cartCount.value,
                      ),
                    ),
                  ),),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
