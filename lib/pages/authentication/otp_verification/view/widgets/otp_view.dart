import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tulsi_hotel/res/colors.dart';

class OtpView extends StatelessWidget {
  const OtpView(
      {super.key,
      required this.otpController,
      this.mOtpCode,
      required this.onCodeChanged,
      this.timeRemaining,
      required this.onResendOtp});

  final Rx<TextEditingController> otpController;
  final RxString? mOtpCode;
  final Function(String?) onCodeChanged;
  final RxInt? timeRemaining;
  final GestureTapCallback onResendOtp;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: PinFieldAutoFill(
          controller: otpController.value,
          currentCode: mOtpCode?.value ?? "",
          keyboardType: TextInputType.number,
          codeLength: 6,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
          ],
          autoFocus: false,
          cursor: Cursor(color: defaultAccentColor, enabled: true, width: 1),
          decoration: BoxLooseDecoration(
              textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: primaryTextColor),
              strokeColorBuilder:
                  PinListenColorBuilder(Color(0xff878787), Color(0xff878787)),
              strokeWidth: 0.4),
          onCodeChanged: (code) {
            onCodeChanged(code.toString());
          },
          onCodeSubmitted: (val) {
            print("onCodeSubmitted $val");
          },
        ),
      ),
    );
  }
}
