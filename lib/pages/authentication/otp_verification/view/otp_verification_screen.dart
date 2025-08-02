import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tulsi_hotel/pages/authentication/login/view/widgets/privacy_policy_text.dart';
import 'package:tulsi_hotel/pages/authentication/otp_verification/view/widgets/otp_view.dart';
import 'package:tulsi_hotel/pages/authentication/otp_verification/controller/otp_verification_controller.dart';
import 'package:tulsi_hotel/pages/authentication/otp_verification/view/widgets/go_back_button_widget.dart';
import 'package:tulsi_hotel/pages/authentication/otp_verification/view/widgets/otp_toolbar_widget.dart';
import 'package:tulsi_hotel/pages/authentication/otp_verification/view/widgets/resend_code_row.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/widgets/custom_views/no_internet_widgets.dart';
import 'package:tulsi_hotel/widgets/progressbar/CustomProgressbar.dart';
import 'package:tulsi_hotel/widgets/text/TitleTextView.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final controller = Get.put(OtpVerificationController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Obx(() {
            return ModalProgressHUD(
                inAsyncCall: controller.isLoading.value,
                opacity: 0,
                progressIndicator: const CustomProgressbar(),
                child: controller.isInternetNotAvailable.value
                    ? NoInternetWidget(
                        onPressed: () {
                          controller.isInternetNotAvailable.value = false;
                          // controller.getTeamListApi();
                        },
                      )
                    : Visibility(
                        visible: controller.isMainViewVisible.value,
                        child: Column(
                          children: [
                            OtpToolbarWidget(),
                            Expanded(
                              // makes it full screen
                              child: Container(
                                padding: EdgeInsets.all(40),
                                width: double.infinity,
                                child: Image.asset(
                                  Drawable.otpVerificationHeaderImage,
                                  // your image path
                                  fit: BoxFit
                                      .contain, // makes the image cover the full screen
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                              child: Column(
                                children: [
                                  TitleTextView(
                                    'we_have_sent_a_verification_code_to'.tr,
                                  ),
                                  TitleTextView(
                                    "+91 - ${controller.phoneNumber}",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  OtpView(
                                    mOtpCode: controller.mOtpCode,
                                    otpController: controller.otpController,
                                    timeRemaining:
                                        controller.otmResendTimeRemaining,
                                    onCodeChanged: (code) {
                                      controller.mOtpCode.value =
                                          code.toString();
                                      print("onCodeChanged $code");
                                      if (controller.mOtpCode.value.length ==
                                          6) {
                                        controller.verifyOtpApi();
                                      }
                                    },
                                    onResendOtp: () {
                                      // controller.teamGenerateOtpApi();
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  ResendCodeRow(),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  GoBackButtonWidget(),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  PrivacyPolicyText(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
          }),
        ),
      ),
    );
  }
}
