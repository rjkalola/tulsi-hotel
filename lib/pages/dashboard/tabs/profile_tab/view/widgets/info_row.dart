import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/profile_tab/controller/profile_tab_controller.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/image_utils.dart';
import 'package:tulsi_hotel/widgets/other_widgets/right_arrow_widget.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextViewInter.dart';

class InfoRow extends StatelessWidget {
  final String iconPath;
  final double iconPadding;
  final String title;
  final String value;
  final bool? rightArrowVisible;
  final controller = Get.put(ProfileTabController());

  InfoRow(
      {required this.iconPath,
      required this.iconPadding,
      required this.title,
      required this.value,
      this.rightArrowVisible});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(rightArrowVisible??false){
          controller.moveToAddress();
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 6),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(iconPadding),
                width: 20,
                height: 20,
                child: SvgPicture.asset(
                  iconPath,
                  colorFilter:
                      ColorFilter.mode(defaultAccentColor, BlendMode.srcIn),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimaryTextViewInter(
                      title,
                      fontSize: 12,
                      color: secondaryTextColor,
                    ),
                    const SizedBox(height: 4),
                    PrimaryTextViewInter(
                      value,
                      fontSize: 15,
                      color: primaryTextColor,
                    ),
                  ],
                ),
              ),
              Visibility(
                  visible: rightArrowVisible ?? false,
                  child: RightArrowWidget()),
              SizedBox(
                width: 6,
              )
            ],
          ),
        ),
      ),
    );
  }
}
