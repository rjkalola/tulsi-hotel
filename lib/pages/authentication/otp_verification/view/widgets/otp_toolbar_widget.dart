import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/utils/image_utils.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextView.dart';

class OtpToolbarWidget extends StatelessWidget {
  const OtpToolbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 14, 10, 0),
      child: Row(children: [
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => Get.back(),
          child: Container(
            padding: const EdgeInsets.fromLTRB(6, 9, 6, 9),
            decoration: AppUtils.getGrayBorderDecoration(
                color: Color(0xFFFFF5E6), radius: 4),
            child: ImageUtils.setSvgAssetsImage(
                path: Drawable.arrowLeftAltIcon, width: 15, height: 15),
          ),
        ),
        const SizedBox(width: 12),
        PrimaryTextView(
          'otp_verification'.tr,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: primaryTextColor,
        )
      ]),
    );
  }
}
