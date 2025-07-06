import 'package:flutter/material.dart';
import 'package:tulsi_hotel/res/colors.dart';


class CustomDivider extends StatelessWidget {
  CustomDivider(
      {super.key, required this.thickness, required this.height, this.color});

  double thickness, height;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      height: height,
      color: color ?? dividerColor,
    );
  }
}
