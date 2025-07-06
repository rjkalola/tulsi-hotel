import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/image_utils.dart';

class PrivacyPolicyText extends StatelessWidget {
  const PrivacyPolicyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ImageUtils.setSvgAssetsImage(
            path: Drawable.arrowRightAltIcon, width: 10, height: 10),
        SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: "${'by_continue_agree_text'.tr} ",
              style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(color: Colors.grey[700], fontSize: 12),
              ),
              children: [
                TextSpan(
                  text: 'terms_of_service'.tr,
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      color: Colors.grey[800],
                    ),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print('Terms of Service tapped');
                    },
                ),
                TextSpan(
                  text: ' & ',
                ),
                TextSpan(
                  text: 'privacy_policy'.tr,
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      color: Colors.grey[800],
                    ),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print('Privacy Policy tapped');
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
