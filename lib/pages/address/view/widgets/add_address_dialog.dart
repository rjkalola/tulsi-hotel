import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/address/model/adress_info.dart';
import 'package:tulsi_hotel/pages/address/view/widgets/add_address_listener.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/utils/string_helper.dart';
import 'package:tulsi_hotel/widgets/buttons/PrimaryButton.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextViewInter.dart';
import 'package:tulsi_hotel/widgets/textfield/text_field_border.dart';

class AddAddressDialog extends StatefulWidget {
  final AddressInfo info;
  final AddAddressListener listener;

  const AddAddressDialog({
    super.key,
    required this.info,
    required this.listener,
  });

  @override
  State<AddAddressDialog> createState() =>
      AddAddressDialogState(info, listener);
}

class AddAddressDialogState extends State<AddAddressDialog> {
  AddressInfo info;
  AddAddressListener listener;
  final flatNumberController = TextEditingController();
  final apartmentController = TextEditingController();
  final areaController = TextEditingController();
  final pinCodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AddAddressDialogState(this.info, this.listener);

  @override
  void initState() {
    super.initState();
    flatNumberController.text = info.flatNumber ?? "";
    apartmentController.text = info.apartment ?? "";
    areaController.text = info.area ?? "";
    pinCodeController.text =
        (info.pincode ?? 0) != 0 ? info.pincode.toString() : "";
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Set a max height for bottom sheet (e.g. 80% of screen)
        double maxHeight = constraints.maxHeight * 0.8;
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: maxHeight,
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 60),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    width: 60,
                    height: 6,
                    decoration: AppUtils.getGrayBorderDecoration(
                        color: Colors.grey.shade300),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  PrimaryTextViewInter(
                    'add_new_address'.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  textFieldWidget(
                      title: 'house_no_flat_no'.tr,
                      textInputAction: TextInputAction.next,
                      controller: flatNumberController),
                  SizedBox(
                    height: 18,
                  ),
                  textFieldWidget(
                      title: 'society_apartment'.tr,
                      textInputAction: TextInputAction.next,
                      controller: apartmentController),
                  SizedBox(
                    height: 18,
                  ),
                  textFieldWidget(
                      title: 'area_name'.tr,
                      textInputAction: TextInputAction.next,
                      controller: areaController),
                  SizedBox(
                    height: 18,
                  ),
                  textFieldNumberWidget(
                      title: 'pin_code'.tr,
                      textInputAction: TextInputAction.next,
                      controller: pinCodeController),
                  SizedBox(
                    height: 24,
                  ),
                  PrimaryButton(
                      buttonText: 'save'.tr,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          info.flatNumber =
                              StringHelper.getText(flatNumberController);
                          info.apartment =
                              StringHelper.getText(apartmentController);
                          info.area = StringHelper.getText(areaController);
                          info.pincode = !StringHelper.isEmptyString(
                                  StringHelper.getText(pinCodeController))
                              ? int.parse(
                                  StringHelper.getText(pinCodeController))
                              : 0;
                          listener.onAddAddress(info);
                        }
                      })
                ]),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget textFieldWidget(
          {required String title,
          required TextEditingController controller,
          TextInputAction? textInputAction}) =>
      TextFieldBorder(
        textEditingController: controller,
        hintText: title,
        labelText: title,
        textInputAction: textInputAction,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onValueChange: (value) {},
        validator: MultiValidator([
          RequiredValidator(errorText: 'required_field'.tr),
        ]),
      );

  Widget textFieldNumberWidget(
          {required String title,
          required TextEditingController controller,
          TextInputAction? textInputAction}) =>
      TextFieldBorder(
        textEditingController: controller,
        hintText: title,
        labelText: title,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onValueChange: (value) {},
        validator: MultiValidator([
          RequiredValidator(errorText: 'required_field'.tr),
        ]),
        inputFormatters: <TextInputFormatter>[
          // for below version 2 use this
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
      );
}
