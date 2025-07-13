import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/widgets/textfield/text_field_border.dart';

class AddYourComments extends StatelessWidget {
  AddYourComments(
      {super.key,
      required this.controller,
      this.onValueChange,});

  final Rx<TextEditingController> controller;
  final ValueChanged<String>? onValueChange;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.fromLTRB(14, 26, 14, 26),
        child: TextFieldBorder(
          textEditingController: controller.value,
          hintText: 'add_your_comments'.tr,
          labelText: 'add_your_comments'.tr,
          textInputAction: TextInputAction.newline,
          validator: MultiValidator([]),
          textAlignVertical: TextAlignVertical.top,
          onValueChange: onValueChange,
          borderRadius: 8,
        ),
      ),
    );
  }
}
