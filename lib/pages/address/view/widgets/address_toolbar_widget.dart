import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/address/controller/address_list_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/view/widgets/add_your_address_here.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/widgets/shapes/badge_count_widget.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextViewInter.dart';

class AddressToolbarWidget extends StatelessWidget {
  AddressToolbarWidget({super.key});

  final controller = Get.put(AddressListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
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
          'your_addresses'.tr,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(width: 12),
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: InkWell(
        //     borderRadius: BorderRadius.circular(12),
        //     onTap: () => Get.back(),
        //     child: Container(
        //       padding: EdgeInsets.all(8),
        //       width: 34,
        //       height: 34,
        //       decoration: AppUtils.getGrayBorderDecoration(
        //           color: Color(0xFFFFF5E6), radius: 4),
        //       child: SvgPicture.asset(
        //         Drawable.cart,
        //         width: 16,
        //         height: 16,
        //       ),
        //     ),
        //   ),
        // ),
      ]),
    );
  }
}
