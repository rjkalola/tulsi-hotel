import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tulsi_hotel/res/colors.dart';

class ResendCodeRow extends StatelessWidget {
  const ResendCodeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "${'did_not_get_the_otp'.tr} ",
          style: GoogleFonts.plusJakartaSans(
            textStyle: TextStyle(
              color: primaryTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          children: <TextSpan>[
            TextSpan(
                text: " ${'resend_otp'.tr}",
                recognizer: TapGestureRecognizer()..onTap = () {},
                style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                        fontSize: 16,
                        color: defaultAccentColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600))),
          ],
        ));
  }
}
