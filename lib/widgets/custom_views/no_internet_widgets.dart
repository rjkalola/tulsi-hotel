import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/widgets/buttons/PrimaryBorderButton.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextView.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryTextView(
             'no_internet_text'.tr,
            fontSize: 18,
            color: primaryTextColor,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 40,
            width: 120,
            child: PrimaryBorderButton(
                buttonText: 'reload'.tr,
                onPressed: () {
                  onPressed!();
                },
                fontColor: defaultAccentColor,
                borderRadius: 45,
                borderColor: defaultAccentColor),
          )
        ],
      ),
    );
  }
}
