import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/routes/app_routes.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/widgets/buttons/PrimaryButton.dart';

import '../../controller/login_controller.dart';

class ContinueButtonWidget extends StatelessWidget {
  ContinueButtonWidget({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: PrimaryButton(
        buttonText: 'continue'.tr,
        onPressed: () {
          if (controller.valid()) {
            controller.login();
          }
        },
      ),
    );
  }
}
