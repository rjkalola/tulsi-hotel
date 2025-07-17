import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tulsi_hotel/pages/common/listener/select_item_listener.dart';
import 'package:tulsi_hotel/pages/common/model/user_info.dart';
import 'package:tulsi_hotel/pages/common/select_Item_list_dialog.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/profile_tab/view/update_profile_data_listener.dart';
import 'package:tulsi_hotel/pages/manageattachment/controller/manage_attachment_controller.dart';
import 'package:tulsi_hotel/pages/manageattachment/listener/select_attachment_listener.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/utils/app_constants.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/utils/image_utils.dart';
import 'package:tulsi_hotel/utils/string_helper.dart';
import 'package:tulsi_hotel/web_services/response/module_info.dart';
import 'package:tulsi_hotel/widgets/buttons/PrimaryButton.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextViewInter.dart';
import 'package:tulsi_hotel/widgets/textfield/text_field_border.dart';

class EditProfileDialog extends StatefulWidget {
  final UserInfo info;
  final UpdateProfileDataListener listener;

  const EditProfileDialog({
    super.key,
    required this.info,
    required this.listener,
  });

  @override
  State<EditProfileDialog> createState() =>
      EditProfileDialogState(info, listener);
}

class EditProfileDialogState extends State<EditProfileDialog>
    implements SelectItemListener, SelectAttachmentListener {
  UserInfo info;
  UpdateProfileDataListener listener;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final imagePath = "".obs;
  final formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final userInfo = UserInfo().obs;

  EditProfileDialogState(this.info, this.listener);

  @override
  void initState() {
    super.initState();
    userInfo.value = info;
    imagePath.value = info.image ?? "";
    nameController.text = userInfo.value.name ?? "";
    emailController.text = userInfo.value.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) => Container(
              decoration: const BoxDecoration(
                  color: backgroundColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 50),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Obx(() =>
                        Column(mainAxisSize: MainAxisSize.min, children: [
                          Container(
                            width: 60,
                            height: 6,
                            decoration: AppUtils.getGrayBorderDecoration(
                                color: Colors.grey.shade300),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          PrimaryTextViewInter(
                            'edit_profile'.tr,
                            fontSize: 18,
                            color: primaryTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ImageUtils.setUserImage(
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              url: imagePath.value ?? ""),
                          const SizedBox(height: 2),
                          PrimaryButton(
                              width: 90,
                              height: 30,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              buttonText: 'change_image'.tr,
                              onPressed: () {
                                showAttachmentOptionsDialog();
                              }),
                          const SizedBox(height: 20),
                          TextFieldBorder(
                            textEditingController: nameController,
                            hintText: 'name'.tr,
                            labelText: 'name'.tr,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onValueChange: (value) {},
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'required_field'.tr),
                            ]),
                            inputFormatters: <TextInputFormatter>[
                              // for below version 2 use this
                              // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextFieldBorder(
                            textEditingController: emailController,
                            hintText: 'email_id'.tr,
                            labelText: 'email_id'.tr,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onValueChange: (value) {},
                            validator: MultiValidator([
                              EmailValidator(
                                  errorText: "enter_valid_email_address".tr),
                            ]),
                            inputFormatters: <TextInputFormatter>[
                              // for below version 2 use this
                              // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          PrimaryButton(
                              height: 44,
                              buttonText: 'save'.tr,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  userInfo.value.name =
                                      StringHelper.getText(nameController);
                                  userInfo.value.email =
                                      StringHelper.getText(emailController);
                                  userInfo.value.image = imagePath.value;
                                  listener.onUpdateProfileData(userInfo.value);
                                  Get.back();
                                }
                              })
                        ])),
                  ),
                ),
              ),
            ));
  }

  showAttachmentOptionsDialog() async {
    var listOptions = <ModuleInfo>[].obs;
    ModuleInfo? info;

    info = ModuleInfo();
    info.name = 'camera'.tr;
    info.action = AppConstants.action.selectImageFromCamera;
    listOptions.add(info);

    info = ModuleInfo();
    info.name = 'gallery'.tr;
    info.action = AppConstants.action.selectImageFromGallery;
    listOptions.add(info);

    Get.bottomSheet(
        SelectItemListDialog(
            title: 'select_photo_from_'.tr,
            dialogType: AppConstants.dialogIdentifier.attachmentOptionsList,
            list: listOptions,
            listener: this),
        backgroundColor: Colors.transparent,
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: false);
  }

  @override
  void onSelectItem(int position, int id, String name, String action) {
    if (action == AppConstants.action.selectImageFromCamera ||
        action == AppConstants.action.selectImageFromGallery) {
      selectPhotoFrom(action);
    }
  }

  void selectPhotoFrom(String action) async {
    try {
      XFile? pickedFile;
      if (action == AppConstants.action.selectImageFromCamera) {
        pickedFile = await _picker.pickImage(
          source: ImageSource.camera,
          maxWidth: 900,
          maxHeight: 900,
          imageQuality: 90,
        );
      } else if (action == AppConstants.action.selectImageFromGallery) {
        pickedFile = await _picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 900,
          maxHeight: 900,
          imageQuality: 90,
        );
      }

      if (pickedFile != null) {
        imagePath.value = pickedFile.path ?? "";
        // ManageAttachmentController().cropImage(pickedFile.path ?? "", this);
      }
    } catch (e) {
      print("error:" + e.toString());
    }
  }

  @override
  void onSelectAttachment(String path, String action) {
    imagePath.value = path ?? "";
    // userInfo.value.image = path ?? "";
    print("Path:" + imagePath.value ?? "");
    // userInfo.refresh();
  }
}
