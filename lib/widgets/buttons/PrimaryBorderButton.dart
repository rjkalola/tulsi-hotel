import 'package:flutter/material.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextView.dart';

class PrimaryBorderButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color? borderColor;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final double? height, width, fontSize, borderRadius, borderWidth;
  final double? elevation;
  final EdgeInsetsGeometry? margin;

  const PrimaryBorderButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.fontColor,
      this.borderColor,
      this.borderRadius,
      this.borderWidth,
      this.height,
      this.width,
      this.fontSize,
      this.elevation,
      this.fontWeight,
      this.margin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.all(0),
      child: OutlinedButton(
        onPressed: () {
          onPressed();
        },
        style: OutlinedButton.styleFrom(
          minimumSize: Size(width ?? double.infinity, height ?? 48),
          elevation: elevation ?? 0,
          side: BorderSide(
              color: borderColor ?? defaultAccentColor,
              width: borderWidth ?? 1),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(borderRadius ?? 45), // corner radius
          ),
        ),
        child: PrimaryTextView(
          buttonText,
          color: fontColor ?? defaultAccentColor,
          fontSize: fontSize ?? 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
