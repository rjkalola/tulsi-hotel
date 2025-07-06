import 'package:flutter/material.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';

class ItemContainer extends StatelessWidget {
  ItemContainer({super.key, required this.child, this.padding, this.margin, this.width, this.height});

  Widget child;
  final EdgeInsetsGeometry? padding, margin;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 0.6, color: AppUtils.haxColor("#d6d6d6")),
        borderRadius: BorderRadius.circular(6),
      ),
      child: child,
    );
  }
}
