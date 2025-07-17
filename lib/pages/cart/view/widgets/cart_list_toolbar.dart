import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/cart/controller/cart_list_controller.dart';
import 'package:tulsi_hotel/pages/cart//view/widgets/add_your_address_here.dart';
import 'package:tulsi_hotel/pages/cart/view/widgets/address_details.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/utils/string_helper.dart';

class CartListToolbar extends StatelessWidget {
  CartListToolbar({super.key});

  final controller = Get.put(CartListController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
        child: Row(children: [
          InkWell(
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
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Visibility(
                  visible: controller.addressVisible.value,
                  child: !StringHelper.isEmptyString(controller.address.value)
                      ? AddressDetails()
                      : AddYourAddressHere())),
          const SizedBox(width: 12),
        ]),
      ),
    );
  }
}
