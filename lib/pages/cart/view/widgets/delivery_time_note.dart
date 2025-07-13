import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/image_utils.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextViewInter.dart';

class DeliveryTimeNote extends StatelessWidget {
  const DeliveryTimeNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      alignment: Alignment.center,
      width: double.infinity,
      color: Color(0xffFE8C00).withAlpha((0.3 * 255).round()),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageUtils.setSvgAssetsImage(
              path: Drawable.deliverTime, width: 12, height: 12),
          SizedBox(width: 4),
          PrimaryTextViewInter(
            'deliver_within_45_mins'.tr,
            fontSize: 12,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
