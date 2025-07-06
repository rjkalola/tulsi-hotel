import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextView.dart';

class LoginOrSignUpText extends StatelessWidget {
  const LoginOrSignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: PrimaryTextView(
        'login_or_sign_up'.tr,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        textAlign: TextAlign.left,
      ),
    );
  }
}
