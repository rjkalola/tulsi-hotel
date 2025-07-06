import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/address/controller/address_list_controller.dart';
import 'package:tulsi_hotel/pages/address/model/adress_info.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/utils/image_utils.dart';
import 'package:tulsi_hotel/widgets/buttons/PrimaryButton.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextView.dart';

class EmptyAddressView extends StatelessWidget {
  EmptyAddressView({super.key});

  final controller = Get.put(AddressListController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ImageUtils.setSvgAssetsImage(
                path: Drawable.address,
                width: 80,
                height: 80,
                color: AppUtils.haxColor("#66FE8C00")),
            SizedBox(
              height: 16,
            ),
            PrimaryTextView(
              'empty_address_message'.tr,
              fontSize: 14,
            ),
            SizedBox(
              height: 6,
            ),
            addButton()
          ],
        ),
      ),
    );
  }

  Widget addButton() => PrimaryButton(
      width: 70,
      height: 32,
      buttonText: 'add'.tr,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      onPressed: () {
        controller.showSelectShiftDialog(AddressInfo());
      });
}
