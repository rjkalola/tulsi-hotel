import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/routes/app_routes.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextViewInter.dart';

class AddYourAddressHere extends StatelessWidget {
  const AddYourAddressHere({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.addressListScreen);
      },
      child: PrimaryTextViewInter(
        'add_your_address_here'.tr,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
