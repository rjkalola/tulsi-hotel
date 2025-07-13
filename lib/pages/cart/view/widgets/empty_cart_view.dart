import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/image_utils.dart';
import 'package:tulsi_hotel/widgets/text/TitleTextView.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageUtils.setSvgAssetsImage(
                path: Drawable.emptyCartIcon, width: 90, height: 90),
            SizedBox(
              height: 18,
            ),
            TitleTextView(
              'empty_cart_message'.tr,
              fontSize: 14,
            ),
            SizedBox(
              height: 20,
            ),
            // PrimaryButton(
            //   buttonText: 'order_now'.tr,
            //   onPressed: () {},
            //   width: 140,
            //   height: 38,
            // )
          ],
        ),
      ),
    );
  }
}
