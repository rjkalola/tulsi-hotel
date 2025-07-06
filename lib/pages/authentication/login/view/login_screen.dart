import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tulsi_hotel/pages/authentication/login/controller/login_controller.dart';
import 'package:tulsi_hotel/pages/authentication/login/view/widgets/app_logo.dart';
import 'package:tulsi_hotel/pages/authentication/login/view/widgets/best_gujarati_dish_text.dart';
import 'package:tulsi_hotel/pages/authentication/login/view/widgets/continue_button_widget.dart';
import 'package:tulsi_hotel/pages/authentication/login/view/widgets/horizontal_dotted_line.dart';
import 'package:tulsi_hotel/pages/authentication/login/view/widgets/login_or_sign_up_text.dart';
import 'package:tulsi_hotel/pages/authentication/login/view/widgets/mobile_number_row.dart';
import 'package:tulsi_hotel/pages/authentication/login/view/widgets/privacy_policy_text.dart';
import 'package:tulsi_hotel/pages/authentication/login/view/widgets/welcome_text.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/image_utils.dart';
import 'package:tulsi_hotel/widgets/custom_views/dotted_line_horizontal_widget.dart';
import 'package:tulsi_hotel/widgets/progressbar/CustomProgressbar.dart';
import 'package:tulsi_hotel/widgets/text/TextViewWithContainer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    /*SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // Optional: Set transparent status/navigation bar colors (for edge-to-edge effect)
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ));*/
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          // appBar: BaseAppBar(
          //   appBar: AppBar(),
          //   title: 'login'.tr,
          //   isCenterTitle: true,
          //   isBack: true,
          // ),
          body: Obx(() {
            return ModalProgressHUD(
              inAsyncCall: loginController.isLoading.value,
              opacity: 0,
              progressIndicator: const CustomProgressbar(),
              child: loginController.isInternetNotAvailable.value
                  ? const Center(
                      child: Text("No Internet"),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          // makes it full screen
                          child: Container(
                            width: double.infinity,
                            child: Image.asset(
                              Drawable
                                  .loginScreenHeaderImage, // your image path
                              fit: BoxFit
                                  .cover, // makes the image cover the full screen
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                          child: Form(
                            key: loginController.formKey,
                            child: Column(
                              children: [
                                AppLogo(),
                                SizedBox(
                                  height: 20,
                                ),
                                BestGujaratiDishText(),
                                SizedBox(
                                  height: 20,
                                ),
                                HorizontalDottedLine(),
                                SizedBox(
                                  height: 20,
                                ),
                                WelcomeText(),
                                LoginOrSignUpText(),
                                SizedBox(
                                  height: 18,
                                ),
                                MobileNumberRow(),
                                SizedBox(
                                  height: 22,
                                ),
                                ContinueButtonWidget(),
                                SizedBox(
                                  height: 18,
                                ),
                                PrivacyPolicyText()
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
            );
          }),
        ),
      ),
    );
  }
}
