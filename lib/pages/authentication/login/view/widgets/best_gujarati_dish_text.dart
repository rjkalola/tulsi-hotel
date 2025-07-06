import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/widgets/text/TextViewWithContainer.dart';

class BestGujaratiDishText extends StatelessWidget {
  const BestGujaratiDishText({super.key});

  @override
  Widget build(BuildContext context) {
    return TextViewWithContainer(
      text: 'best_gujarati_dishes_and_tiffins'.tr,
      width: double.infinity,
      fontStyle: FontStyle.italic,
      fontColor: defaultAccentColor,
      borderColor: defaultAccentColor,
      fontSize: 14,
      borderWidth: 0.4,
      padding: EdgeInsets.all(6),
      borderRadius: 45,
      alignment: Alignment.center,
    );
  }
}
