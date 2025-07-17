import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tulsi_hotel/pages/common/listener/DialogButtonClickListener.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/profile_tab/controller/profile_tab_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/profile_tab/view/widgets/info_row.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/utils/image_utils.dart';
import 'package:tulsi_hotel/utils/string_helper.dart';
import 'package:tulsi_hotel/widgets/buttons/PrimaryButton.dart';
import 'package:tulsi_hotel/widgets/container/ItemContainer.dart';
import 'package:tulsi_hotel/widgets/custom_views/no_internet_widgets.dart';
import 'package:tulsi_hotel/widgets/other_widgets/right_arrow_widget.dart';
import 'package:tulsi_hotel/widgets/progressbar/CustomProgressbar.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextViewInter.dart';

import '../../../../../res/colors.dart';
import '../../../../../utils/AlertDialogHelper.dart';
import '../../../../../utils/app_constants.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with AutomaticKeepAliveClientMixin
    implements DialogButtonClickListener {
  int selectedActionButtonPagerPosition = 0;
  final controller = Get.put(ProfileTabController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: backgroundColor,
        // backgroundColor: const Color(0xfff4f5f7),
        body: controller.isInternetNotAvailable.value
            ? NoInternetWidget(
                onPressed: () {
                  controller.isInternetNotAvailable.value = false;
                  controller.getProfileInfoApi(true);
                },
              )
            : ModalProgressHUD(
                inAsyncCall: controller.isLoading.value,
                opacity: 0,
                progressIndicator: const CustomProgressbar(),
                child: Visibility(
                  visible: controller.isMainViewVisible.value,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ImageUtils.setUserImage(
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              url: controller.userInfo.value.image ?? ""),
                          const SizedBox(height: 12),
                          PrimaryTextViewInter(
                            getFinalString(
                                controller.userInfo.value.name ?? ""),
                            color: primaryTextColor,
                            fontSize: 18,
                          ),
                          const SizedBox(height: 6),
                          PrimaryButton(
                              width: 100,
                              height: 30,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              buttonText: 'edit_profile'.tr,
                              onPressed: () {
                                controller.showEditProfileDialog();
                              }),
                          const SizedBox(height: 30),
                          InfoRow(
                            iconPath: Drawable.phoneIcon,
                            iconPadding: 0,
                            title: 'mobile_no'.tr,
                            value:
                                "+91 - ${getFinalString(controller.userInfo.value.phoneNumber ?? "")}",
                          ),
                          const Divider(
                            color: dividerColor,
                          ),
                          InfoRow(
                            iconPath: Drawable.mailIcon,
                            iconPadding: 1,
                            title: 'email_id'.tr,
                            value: getFinalString(
                                controller.userInfo.value.email ?? ""),
                          ),
                          const Divider(
                            color: dividerColor,
                          ),
                          InfoRow(
                            iconPath: Drawable.address,
                            iconPadding: 0,
                            title: 'your_addresses'.tr,
                            value: getFinalString(
                                controller.userInfo.value.address ?? ""),
                            rightArrowVisible: true,
                          ),
                          const Divider(
                            color: dividerColor,
                          ),
                          const SizedBox(height: 26),
                          GestureDetector(
                            onTap: () {
                              AlertDialogHelper.showAlertDialog(
                                  "",
                                  'logout_msg'.tr,
                                  'yes'.tr,
                                  'no'.tr,
                                  "",
                                  true,
                                  this,
                                  AppConstants.dialogIdentifier.logout);
                            },
                            child: ItemContainer(
                                padding: EdgeInsets.fromLTRB(16, 11, 16, 11),
                                borderColor: AppUtils.haxColor("#ff4040"),
                                child: Row(
                                  children: [
                                    ImageUtils.setSvgAssetsImage(
                                        path: Drawable.logoutIcon,
                                        width: 18,
                                        height: 18),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: PrimaryTextViewInter(
                                        'logout'.tr,
                                        color: AppUtils.haxColor("#ff4040"),
                                        fontSize: 16,
                                      ),
                                    ),
                                    RightArrowWidget()
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

        /* body: Visibility(
          visible: controller.isMainViewVisible.value,
          child: Column(children: [
            HeaderUserDetailsView(),
            SizedBox(
              height: 12,
            ),
            DashboardGridView()
          ]),
        ),*/
      ),
    );
  }

  String getFinalString(input) {
    return !StringHelper.isEmptyString(input) ? input : "-";
  }

  @override
  void onNegativeButtonClicked(String dialogIdentifier) {
    if (dialogIdentifier == AppConstants.dialogIdentifier.logout) {
      Get.back();
    }
  }

  @override
  void onOtherButtonClicked(String dialogIdentifier) {}

  @override
  void onPositiveButtonClicked(String dialogIdentifier) {
    if (dialogIdentifier == AppConstants.dialogIdentifier.logout) {
      controller.logoutApi(true);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
