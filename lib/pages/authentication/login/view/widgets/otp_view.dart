import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextView.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpView extends StatelessWidget {
  OtpView(
      {super.key,
      required this.otpController,
      this.mOtpCode,
      required this.onCodeChanged,
      required this.onResendOtp,
      this.timeRemaining});

  final Rx<TextEditingController> otpController;
  final RxString? mOtpCode;
  final RxInt? timeRemaining;
  final Function(String?) onCodeChanged;

  // final VoidCallback onResendOtp;
  final GestureTapCallback onResendOtp;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        decoration: AppUtils.getGrayBorderDecoration(
          borderColor: Colors.grey.shade300,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PrimaryTextView(
              'enter_verification_code'.tr,
              fontSize: 20,
              color: primaryTextColor,
              fontWeight: FontWeight.w500,
            ),
            PrimaryTextView(
              'verification_code_sent_note'.tr,
              fontSize: 15,
              color: primaryTextColor,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 14,
            ),
            Center(
              child: SizedBox(
                width: 300,
                child: PinFieldAutoFill(
                  controller: otpController.value,
                  currentCode: mOtpCode?.value ?? "",
                  keyboardType: TextInputType.number,
                  codeLength: 6,
                  inputFormatters: <TextInputFormatter>[
                    // for below version 2 use this
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  autoFocus: true,
                  cursor: Cursor(
                      color: defaultAccentColor, enabled: true, width: 1),
                  decoration: BoxLooseDecoration(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: primaryTextColor),
                    strokeColorBuilder: PinListenColorBuilder(
                        Color(0xffc6c6c6), Color(0xffc6c6c6)),
                  ),
                  onCodeChanged: (code) {
                    // print("onCodeChanged::: $code");
                    onCodeChanged(code.toString());
                    // verifyOtpController.mOtpCode.value = code.toString();
                  },
                  onCodeSubmitted: (val) {
                    print("onCodeSubmitted $val");
                  },
                  // enabled: !verifyOtpController.isOtpFilled.value,
                ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            PrimaryTextView(
              "${'resend_code_in'.tr} ${timeRemaining.toString().padLeft(2, '0')}",
              fontSize: 16,
              color: primaryTextColor,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 18,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "${'did_not_get_the_code'.tr} ",
                  style: const TextStyle(
                      fontSize: 16,
                      color: secondaryLightTextColor,
                      fontWeight: FontWeight.w400),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'resend_now'.tr,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (timeRemaining?.value == 0) onResendOtp();
                          },
                        style: TextStyle(
                            fontSize: 16,
                            color: timeRemaining?.value == 0
                                ? defaultAccentColor
                                : secondaryExtraLightTextColor,
                            fontWeight: FontWeight.w500)),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
