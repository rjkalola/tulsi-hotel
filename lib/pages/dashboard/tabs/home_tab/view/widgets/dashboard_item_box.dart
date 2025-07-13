import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/authentication/login/view/widgets/horizontal_dotted_line.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/routes/app_routes.dart';
import 'package:tulsi_hotel/utils/image_utils.dart';
import 'package:tulsi_hotel/widgets/text/SubTitleTextView.dart';
import 'package:tulsi_hotel/widgets/text/TitleTextView.dart';

import '../../../../../../utils/app_constants.dart';

class DashboardItemBox extends StatelessWidget {
  DashboardItemBox(
      {super.key,
      required this.title,
      required this.time,
      required this.visible,
      required this.productType,
      required this.dayType});

  String title, time;
  bool visible;
  int productType = 0, dayType = 0;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: GestureDetector(
        onTap: () {
          var arguments = {
            AppConstants.intentKey.productType: productType,
          };
          Get.toNamed(AppRoutes.productListScreen, arguments: arguments);
        },
        child: Container(
          margin: const EdgeInsets.only(top: 14),
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextView(
                        title,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      SubtitleTextView(
                        time,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    ],
                  ),
                  ImageUtils.setAssetsImage(
                      path: Drawable.dashboardDish, width: 46, height: 46),
                ],
              ),
              const SizedBox(height: 16),
              HorizontalDottedLine(),
              const SizedBox(height: 13),
              Row(
                children: [
                  Expanded(
                    child: SubtitleTextView(
                      'any_2_sabji_roti_khachdi_kadhi_papad_salad'.tr,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  ImageUtils.setSvgAssetsImage(
                      path: Drawable.rightArrow, width: 12, height: 12),
                  SizedBox(
                    width: 4,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0B2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageUtils.setSvgAssetsImage(
                        path: Drawable.deliverTime, width: 12, height: 12),
                    SizedBox(width: 4),
                    TitleTextView(
                      'deliver_within_45_mins'.tr,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
