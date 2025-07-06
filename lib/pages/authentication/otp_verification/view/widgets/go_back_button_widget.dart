import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/authentication/otp_verification/controller/otp_verification_controller.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/widgets/buttons/PrimaryButton.dart';

class GoBackButtonWidget extends StatelessWidget {
  GoBackButtonWidget({super.key});

  final controller = Get.put(OtpVerificationController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: PrimaryButton(
        buttonText: 'continue'.tr,
        onPressed: () {
          if (controller.mOtpCode.value.length == 6) {
            controller.verifyOtpApi();
          } else {
            AppUtils.showSnackBarMessage('enter_otp'.tr);
          }
        },
      ),
    );
  }
}
