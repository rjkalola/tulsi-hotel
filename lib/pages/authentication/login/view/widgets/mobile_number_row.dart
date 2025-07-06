import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/widgets/textfield/text_field_border.dart';

import '../../controller/login_controller.dart';

class MobileNumberRow extends StatelessWidget {
  MobileNumberRow({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return TextFieldBorder(
        textEditingController: controller.phoneController.value,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.number,
        maxLength: 10,
        labelText: 'Enter Mobile Number',
        hintText: 'Enter Mobile Number',
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 14, right: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                '+91',
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(width: 14),
              Text('-'),
              SizedBox(width: 8),
            ],
          ),
        ),
        validator: MultiValidator([
          RequiredValidator(errorText: 'enter_your_mobile_number'.tr),
        ]),
        inputFormatters: <TextInputFormatter>[
          // for below version 2 use this
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          LengthLimitingTextInputFormatter(10),
        ]);
  }
}
