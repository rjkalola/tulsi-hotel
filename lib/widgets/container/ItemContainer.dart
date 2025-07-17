import 'package:flutter/material.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';

class ItemContainer extends StatelessWidget {
  ItemContainer(
      {super.key,
      required this.child,
      this.padding,
      this.margin,
      this.width,
      this.height,
      this.borderRadius,
      this.borderColor});

  Widget child;
  final EdgeInsetsGeometry? padding, margin;
  final double? width, height, borderRadius;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
            width: 0.4, color: borderColor ?? AppUtils.haxColor("#878787")),
        borderRadius: BorderRadius.circular(borderRadius ?? 6),
      ),
      child: child,
    );
  }
}
